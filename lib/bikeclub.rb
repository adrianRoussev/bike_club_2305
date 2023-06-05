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
end