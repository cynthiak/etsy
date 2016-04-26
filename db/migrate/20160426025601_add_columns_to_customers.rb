class AddColumnsToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :company, :string
    add_column :customers, :instagram, :string
  end

  def self.down
    remove_column :products, :company
    remove_column :products, :instagram
  end
end
