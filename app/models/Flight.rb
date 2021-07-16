class Flight < ActiveRecord::Base
    belongs_to :destination
    has_many :tickets
    has_many :passengers, through: :tickets

    def self.create_flight(airline_name, departure, destination, arrival, flight_num, max_cap)
        Flight.create(airline_name: airline_name, departure: departure, destination: destination, arrival: arrival, flight_num: flight_num, max_cap: max_cap)
    end

    def cancel_flight
        self.tickets.each {|ticket| ticket.destroy}
        self.destroy
    end

    def self.destinations
        self.all.collect{|flight| flight.destination}.uniq
    end

    def pass_tix
        
    end
end