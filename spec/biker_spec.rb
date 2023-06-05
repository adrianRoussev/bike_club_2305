require 'rspec'
require './lib/ride.rb'
require './lib/biker.rb'

describe Biker do
  let(:ride) { Ride.new(name: 'Mountain Trail', distance: 10, loop: true, terrain: 'Rocky') }

  describe '#initialize' do
    it 'creates a new Biker instance with the specified attributes' do
      biker = Biker.new('Adrian', 50)
      
      expect(biker.name).to eq('Adrian')
      expect(biker.max_distance).to eq(50)
      expect(biker.rides).to eq({})
      expect(biker.acceptable_terrain).to eq([])
    end
  end

  describe '#learn_terrain!' do
    it 'adds the terrain to acceptable_terrain if not already present' do
      biker = Biker.new('Adrian', 50)
      
      biker.learn_terrain!('Rocky')
      biker.learn_terrain!('Paved')
      
      expect(biker.acceptable_terrain).to contain_exactly('Rocky', 'Paved')
    end
    
    it 'does not add the terrain if already present in acceptable_terrain' do
      biker = Biker.new('Adrian', 50)
      
      biker.learn_terrain!('Rocky')
      biker.learn_terrain!('Rocky')
      
      expect(biker.acceptable_terrain).to contain_exactly('Rocky')
    end
  end

  describe '#log_ride' do
    describe 'when the ride is acceptable and within distance limit' do
      it 'logs the ride time for the given ride' do
        biker = Biker.new('Adrian', 50)
        
        biker.learn_terrain!('Rocky')
        biker.log_ride(ride, 60)
        
        expect(biker.rides[ride]).to eq([60])
      end
      
      it 'appends the ride time if the ride has been logged previously' do
        biker = Biker.new('Adrian', 50)
        
        biker.learn_terrain!('Rocky')
        biker.log_ride(ride, 60)
        biker.log_ride(ride, 70)
        
        expect(biker.rides[ride]).to eq([60, 70])
      end
    end
    
    describe 'when the ride is not acceptable or exceeds distance limit' do
      it 'does not log the ride time' do
        biker = Biker.new('Adrian', 50)
        
        biker.learn_terrain!('Paved')
        biker.log_ride(ride, 60)
        
        expect(biker.rides[ride]).to be_nil
      end
    end
  end

  describe '#personal_record' do
    describe 'when the ride has been logged' do
      it 'returns the minimum ride time' do
        biker = Biker.new('Adrian', 50)
        
        biker.learn_terrain!('Rocky')
        biker.log_ride(ride, 60)
        biker.log_ride(ride, 70)
        
        expect(biker.personal_record(ride)).to eq(60)
      end
    end
    
    describe 'when the ride has not been logged' do
      it 'returns false' do
        biker = Biker.new('Adrian', 50)
        
        expect(biker.personal_record(ride)).to be false
      end
    end
  end

  describe '#total_rides' do
    it 'returns the total number of rides logged' do
      biker = Biker.new('Adrian', 50)
      
      biker.learn_terrain!('Rocky')
      biker.log_ride(ride, 60)
      biker.log_ride(ride, 70)
      
      expect(biker.total_rides).to eq(2)
    end
  end

  describe '#eligible_for_ride?' do
    describe 'when the biker is eligible for the ride' do
      it 'returns true' do
        biker = Biker.new('Adrian', 50)
        
        biker.learn_terrain!('Rocky')
        
        expect(biker.eligible_for_ride?(ride)).to be true
      end
    end
    
    describe 'when the biker is not eligible for the ride' do
      it 'returns false' do
        biker = Biker.new('Adrian', 50)
        
        biker.learn_terrain!('Paved')
        
        expect(biker.eligible_for_ride?(ride)).to be false
      end
    end
  end

  describe '#set_ride_start_time' do
    it 'sets the ride start time for the biker' do
      biker = Biker.new('Adrian', 50)
      start_time = Time.now
      
      biker.set_ride_start_time(start_time)
      
      expect(biker.instance_variable_get(:@ride_start_time)).to eq(start_time)
    end
  end

  

end
