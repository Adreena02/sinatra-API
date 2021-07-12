class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :passenger_id
      t.integer :flight_id
      t.string :destination
    end
  end
end
