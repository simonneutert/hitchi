class CreateDepartures < ActiveRecord::Migration[4.2]
  def change
    create_table :departures do |t|
      t.string :name, index: true
      t.float :latitude, index: true
      t.float :longitude, index: true

      t.timestamps null: false
    end
  end
end
