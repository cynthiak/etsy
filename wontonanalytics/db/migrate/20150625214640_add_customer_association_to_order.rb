class AddCustomerAssociationToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :customer_id, :integer
    add_index 'orders', ['customer_id'], :name => 'index_customer_id'
  end

  def self.down
    remove_column :orders, :customer_id
  end
end
