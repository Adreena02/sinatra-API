class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :airline_name
      t.datetime :departure
      t.datetime :arrival
      t.integer :flight_num
      t.integer :max_cap
      t.string :destination
    end
  end
end
