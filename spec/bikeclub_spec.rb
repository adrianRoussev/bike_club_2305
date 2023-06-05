require 'rspec'
require './lib/ride.rb'
require './lib/biker.rb'
require './lib/bikeclub.rb'

describe BikeClub do
  let(:bike_club) { BikeClub.new("Awesome Bike Club") }
  let(:ride) { instance_double("Ride") }
  let(:biker1) { instance_double("Biker1") }
  let(:biker2) { instance_double("Biker2") }

  before do
    allow(ride).to receive(:total_distance).and_return(10)
    allow(biker1).to receive(:personal_record).with(ride).and_return(60)
    allow(biker2).to receive(:personal_record).with(ride).and_return(45)
    bike_club.add_biker(biker1)
    bike_club.add_biker(biker2)
  end

  describe "#add_biker" do
    it "adds a biker to the bikers list" do
      bike_club.add_biker(biker1)
      expect(bike_club.bikers).to include(biker1)
    end
  end

  describe "#biker_with_most_rides" do
    it "returns the biker with the most rides" do
      allow(biker1).to receive(:total_rides).and_return(5)
      allow(biker2).to receive(:total_rides).and_return(10)
      expect(bike_club.biker_with_most_rides).to eq(biker2)
    end
  end

  describe "#biker_with_best_time_for_ride" do
    it "returns the biker with the best personal record for the ride" do
      expect(bike_club.biker_with_best_time_for_ride(ride)).to eq(biker2)
    end
  end

  describe "#eligible_bikers_for_ride" do
    it "returns the eligible bikers for the ride" do
      allow(biker1).to receive(:eligible_for_ride?).with(ride).and_return(false)
      allow(biker2).to receive(:eligible_for_ride?).with(ride).and_return(true)
      expect(bike_club.eligible_bikers_for_ride(ride)).to eq([biker2])
    end
  end

  describe "#start_group_ride" do
    it "sets the group ride start time for all bikers" do
      current_time = Time.now
      allow(bike_club).to receive(:current_time).and_return(current_time)
      expect(biker1).to receive(:set_ride_start_time).with(current_time)
      expect(biker2).to receive(:set_ride_start_time).with(current_time)
      bike_club.start_group_ride(ride)
    end
  end

  describe "#finish_group_ride" do
    it "logs the ride and updates the best rider" do
      current_time = Time.now
      allow(bike_club).to receive(:current_time).and_return(current_time)
      allow(bike_club).to receive(:calculate_ride_time).and_return(30)
      expect(biker1).to receive(:log_ride).with(ride, 30)
      expect(biker2).to receive(:log_ride).with(ride, 30)
      expect(bike_club).to receive(:update_best_rider).with(ride)
      bike_club.finish_group_ride(ride)
    end
  end

  describe "#calculate_ride_time" do
    it "calculates the ride time in minutes" do
      start_time = Time.new(2023, 6, 1, 10, 0, 0)
      end_time = Time.new(2023, 6, 1, 10, 30, 0)
      expected_ride_time = 30
      expect(bike_club.calculate_ride_time(start_time, end_time)).to eq(expected_ride_time)
    end
  end

  describe "#current_time" do
    it "returns the current time" do
      current_time = Time.now
      allow(Time).to receive(:now).and_return(current_time)
      expect(bike_club.current_time).to eq(current_time)
    end
  end
end
