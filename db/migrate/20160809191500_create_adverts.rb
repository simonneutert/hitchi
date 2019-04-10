class CreateAdverts < ActiveRecord::Migration[4.2]
  def change
    create_table :adverts do |t|
      t.string :title
      t.string :client
      t.string :linkurl
      t.string :city, index: true
      t.references :admin, foreign_key: true, index: true
      t.integer :viewcounter, default: 0, null: false
      t.integer :clickcounter, default: 0, null: false
      t.date :begin_ad, index: true
      t.date :end_ad, index: true

      t.timestamps null: false
    end
  end
end
