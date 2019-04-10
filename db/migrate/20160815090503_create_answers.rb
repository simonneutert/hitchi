class CreateAnswers < ActiveRecord::Migration[4.2]
  def change
    create_table :answers do |t|
      t.belongs_to :message, index: true, foreign_key: true
      t.string :content
      t.integer :recipent
      t.integer :sender
      t.belongs_to :user, index: true, foreign_key: true
      t.string :status

      t.timestamps null: false
    end
  end
end
