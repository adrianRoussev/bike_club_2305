require 'rspec'
require './lib/ride.rb'

describe Ride do
  describe '#initialize' do
    it 'creates a new Ride instance with the specified attributes' do
      ride_specs = { name: 'Mountain Trail', distance: 10, loop: true, terrain: 'Rocky' }
      ride = Ride.new(ride_specs)
      
      expect(ride.name).to eq('Mountain Trail')
      expect(ride.distance).to eq(10)
      expect(ride.loop?).to be true
      expect(ride.terrain).to eq('Rocky')
    end
  end
  
  describe '#total_distance' do
    describe 'when the ride is a loop' do
      it 'returns the distance as is' do
        ride_specs = { name: 'Park Loop', distance: 5, loop: true, terrain: 'Paved' }
        ride = Ride.new(ride_specs)
        
        expect(ride.total_distance).to eq(5)
      end
    end
    
    describe 'when the ride is not a loop' do
      it 'returns double the distance' do
        ride_specs = { name: 'City Tour', distance: 10, loop: false, terrain: 'Urban' }
        ride = Ride.new(ride_specs)
        
        expect(ride.total_distance).to eq(20)
      end
    end
  end
end
