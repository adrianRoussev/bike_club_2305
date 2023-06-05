class Biker
    attr_reader :name, :max_distance, :rides, :acceptable_terrain
  
    def initialize(name, max_distance)
      @name = name
      @max_distance = max_distance
      @rides = {}
      @acceptable_terrain = []
    end
  
   def learn_terrain!(terrain)
    if !@acceptable_terrain.include?(terrain)
      @acceptable_terrain << terrain
    end
  end
  
    def log_ride(ride, time)
    if acceptable_terrain.include?(ride.terrain) && ride.total_distance <= max_distance
      if @rides.key?(ride)
        @rides[ride] << time
      else
        @rides[ride] = [time]
      end
    end
  end
  
    def personal_record(ride)
      if @rides.key?(ride)
        @rides[ride].min
      else
        false
      end
    end

    def total_rides
      @rides.values.flatten.size
    end

    def eligible_for_ride?(ride)
      acceptable_terrain.include?(ride.terrain) && ride.total_distance <= max_distance
    end

    def set_ride_start_time(time)
      @ride_start_time = time
    end

    def log_ride_time(ride_time)
      @rides[@ride_start_time] = ride_time
    end

    def personal_best_time
      @rides.values.min
    end
end
