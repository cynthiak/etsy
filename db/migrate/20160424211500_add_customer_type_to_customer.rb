class AddCustomerTypeToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :customer_type, :string
  end

  def self.down
    remove_column :products, :customer_type
  end
end
