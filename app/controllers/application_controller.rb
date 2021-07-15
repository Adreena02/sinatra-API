class ApplicationController < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, "*" 
    set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
    set :expose_headers, ['Content-Type']
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,PATCH,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    200
  end

  get "/flights" do 
    Flight.all.to_json
  end

  get '/destinations' do 
    Destination.all.to_json
  end

  get '/passengers' do
    Passenger.all.to_json
  end

  get "/passenger_tickets/:id" do
    # Ticket.all.where(passenger_id: params[:id]).map{|ticket|Flight.all.find_by(id: ticket.id)}.map{|flight| {id: flight.id, airline_name: flight.airline_name, departure: flight.departure, arrival: flight.arrival, flight_num: flight.flight_num, max_cap: flight.max_cap, destination: Destination.all.find_by(id: flight.id).location_name }}.to_json

    Passenger.find_by(id: params[:id]).flights.to_json(include: :destination)
  end

  get "/flights_to_destination/:id" do
      Flight.all.where(destination_id: params[:id]).to_json
  end
  
  post "/new_ticket" do
    ticket = Ticket.create(passenger_id: params[:passenger_id], flight_id: params[:flight_id])
    ticket.to_json
  end

  delete "/delete_ticket/:id" do
    Ticket.find_by(id: params[:id]).destroy.to_json
  end
end
