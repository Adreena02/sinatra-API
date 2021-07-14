class ApplicationController < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, "*" 
    set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
    set :expose_headers, ['Content-Type']
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
    Flight.destinations.to_json
  end

  get "/tickets_for_passenger" do
    Tickets.all
  end
  
  post "/new_ticket" do
    # puts params.inspect
    # ticket_params = params.find do |key|
    #   ["flight_id","passenger_id"].include?(key)
    # end
    ticket = Ticket.create(passenger_id: params[:passenger_id], flight_id: params[:flight_id])
    #ticket.any_instance_method
    ticket.to_json
  end

end
