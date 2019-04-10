class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :recipent
      t.integer :sender
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :offer, index: true, foreign_key: true
      t.string :status

      t.timestamps null: false
    end
  end
end
