class AddEmailNotificationselectToOffers < ActiveRecord::Migration[4.2]
  def change
    add_column :offers, :emailnotification, :boolean, :default => false, index: true
  end
end
