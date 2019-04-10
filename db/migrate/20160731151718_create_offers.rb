class CreateOffers < ActiveRecord::Migration[4.2]
  def change
    create_table :offers do |t|
      t.string :departurelocal, index: true
      t.date :departuredate, index: true
      t.string :departuretime
      t.string :destinationlocal, index: true
      t.string :description
      t.string :between_stops, index: true
      t.boolean :seek, index: true
      t.boolean :active, index: true
      t.boolean :rules
      t.references :user, foreign_key: true, index: true
      t.references :departure, foreign_key: true, index: true
      t.references :destination, foreign_key: true, index: true
      t.integer :viewcounter, :default => 0
      t.integer :clickcounter, :default => 0

      t.timestamps null: false
    end
  end
end
