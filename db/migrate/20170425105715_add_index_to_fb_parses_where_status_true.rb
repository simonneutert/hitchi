class AddIndexToFbParsesWhereStatusTrue < ActiveRecord::Migration[5.0]
  def change
    add_index :fb_parses, :status, name: "index_statuses_on_true", where: "(status IS TRUE)"
  end
end
