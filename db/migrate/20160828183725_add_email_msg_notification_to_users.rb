class AddEmailMsgNotificationToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :emailmsgnotification, :timestamp, :default => nil, index: true
  end
end
