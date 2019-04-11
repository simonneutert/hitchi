class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps null: false
    end
  end
end
