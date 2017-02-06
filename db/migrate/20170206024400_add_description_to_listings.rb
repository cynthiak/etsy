class AddDescriptionToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :item_name, :string
  end

  def self.down
    remove_column :listings, :item_name
  end
end
