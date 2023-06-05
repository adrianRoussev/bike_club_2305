class Ride
    attr_reader :name, :distance, :terrain

    def initialize(ride_specs)
        @name = ride_specs[:name]
        @distance = ride_specs[:distance]
        @loop = ride_specs[:loop]
        @terrain = ride_specs[:terrain]
    end

    def loop?
        @loop
    end

    def total_distance
        if loop?
            @distance 
        else 
            @distance * 2
        end
    end
end
