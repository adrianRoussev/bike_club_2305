class BikeClub
    attr_reader :name, :bikers
  
    @@best_rider = nil
  
    def initialize(name)
      @name = name
      @bikers = []
    end
  
    def add_biker(biker)
      @bikers << biker
    end
  
     def biker_with_most_rides
      @bikers.max_by { |biker| biker.total_rides }
    end
  
    def biker_with_best_time_for_ride(ride)
      @bikers.min_by { |biker| biker.personal_record(ride) }
    end
  
    def eligible_bikers_for_ride(ride)
      @bikers.select { |biker| biker.eligible_for_ride?(ride) }
    end
  
    def start_group_ride(ride)
      @group_ride_start_time = current_time
      @bikers.each { |biker| biker.set_ride_start_time(@group_ride_start_time) }
    end
  
    def finish_group_ride(ride)
      @bikers.each do |biker|
        ride_time = calculate_ride_time(biker.ride_start_time, current_time)
        biker.log_ride(ride, ride_time)
      end
      update_best_rider(ride)
      @group_ride_start_time = nil
    end
  
    def calculate_ride_time(start_time, end_time)
      (end_time - start_time) / 60 
    end
  
    def current_time
      Time.now
    end
  
    def self.best_rider(ride)
      @@best_rider
    end
  
  
    def update_best_rider(ride)
      @bikers.each do |biker|
        if @@best_rider.nil? || biker.personal_record(ride) < @@best_rider.personal_record(ride)
          @@best_rider = biker
        end
      end
    end
  end
  