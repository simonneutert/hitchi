class AddMessageStatusToMessages < ActiveRecord::Migration[4.2]
  def change
    add_column :messages, :senderclick, :boolean
    add_column :messages, :recipentclick, :boolean
  end
end
