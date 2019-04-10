class ChangeOfferStringToText < ActiveRecord::Migration[4.2]
  def change
    change_column :offers, :description, :text
  end
end
