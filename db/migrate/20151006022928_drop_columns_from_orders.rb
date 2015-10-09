class DropColumnsFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :ship_address1
    remove_column :orders, :ship_address2
    remove_column :orders, :ship_city
    remove_column :orders, :ship_state
    remove_column :orders, :ship_zipcode
    remove_column :orders, :ship_country
    remove_column :orders, :status
    remove_column :orders, :buyer
    remove_column :orders, :packaging_cost
    remove_column :orders, :shipping_cost
    remove_column :orders, :notes
  end

  def down
    add_column :orders, :ship_address1, :text
    add_column :orders, :ship_address2, :text
    add_column :orders, :ship_city, :text
    add_column :orders, :ship_state, :text
    add_column :orders, :ship_zipcode, :text
    add_column :orders, :ship_country, :text
    add_column :orders, :status, :text
    add_column :orders, :buyer, :text
    add_column :orders, :packaging_cost, :float
    add_column :orders, :shipping_cost, :float
    add_column :orders, :notes, :text
  end
end
