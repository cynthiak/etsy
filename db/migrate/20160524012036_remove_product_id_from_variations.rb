class RemoveProductIdFromVariations < ActiveRecord::Migration
  def self.up
    remove_column :variations, :product_id
  end

  def self.down
    add_column :variations, :product_id, :integer
  end
end
