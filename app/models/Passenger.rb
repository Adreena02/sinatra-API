class Passenger < ActiveRecord::Base
    has_many :tickets
    has_many :flights, through: :tickets

    def create_ticket(destination)
        Ticket.create(passenger_id: self.id, flight_id: Flight.all.find_by(destination: destination).id)
    end

    def cancel_ticket(flight)
        self.tickets.find_by(flight_id: flight.id).destroy
    end


    # def flight_and_ticket
    #     self.tickets.map do |ticket|
    #         {
    #             ticket_id: ticket.id,
    #             flight: ticket.flight,
    #             destination_name: ticket.flight.destination.location_name,
    #             name: "greg"
    #         }
    #     end 
    # end 

end