class AddColumnsToVariations < ActiveRecord::Migration
  def self.up
    add_column :variations, :quantity, :integer
    add_column :variations, :device, :string
    remove_column :variations, :variation_name
  end

  def self.down
    remove_column :variations, :quantity
    remove_column :variations, :device
    add_column :variations, :variation_name, :string
  end
end
