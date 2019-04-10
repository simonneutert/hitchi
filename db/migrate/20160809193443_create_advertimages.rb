class CreateAdvertimages < ActiveRecord::Migration[4.2]
  def change
    create_table :advertimages do |t|
      t.string :image
      t.references :advert, foreign_key: true, index: true

      t.timestamps null: false
    end
  end
end
