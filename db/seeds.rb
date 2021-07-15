require 'faker'

puts "Clearing old flights..."
Passenger.destroy_all
Passenger.reset_pk_sequence
Flight.destroy_all
Flight.reset_pk_sequence
Ticket.destroy_all
Ticket.reset_pk_sequence
Destination.destroy_all
Destination.reset_pk_sequence


puts "Seeding passengers..."

20.times do
    Passenger.create(name: Faker::Name.unique.name, age: rand(20..60))
end

puts "Seeding destinations..."
20.times do
    Destination.create(location_name: Faker::Fantasy::Tolkien.location)
end

puts "Seeding flights..."
airline_names = ['Jetblue', 'United', 'Delta', 'Spirit']
10.times do
    Flight.create(airline_name: airline_names.sample, departure: Faker::Date.between(from: Date.today, to: "2021-07-19"), arrival: Faker::Date.between(from: Date.today, to: "2021-07-19"), flight_num: rand(150..300), max_cap: rand(45..70), destination_id: Destination.ids.sample)
end

puts "Seeding tickets..."
20.times do
    Ticket.create(passenger_id: Passenger.ids.sample, flight_id: Flight.ids.sample)
end


puts "Done!"