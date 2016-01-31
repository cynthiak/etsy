class AddFieldsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :occasion, :string
    add_column :products, :cost, :float
  end

  def self.down
    remove_column :products, :occasion
    remove_column :products, :cost
  end
end
