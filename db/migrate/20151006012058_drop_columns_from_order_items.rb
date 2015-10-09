class DropColumnsFromOrderItems < ActiveRecord::Migration
  def up
    remove_column :order_items, :buyer
    remove_column :order_items, :ship_name
    remove_column :order_items, :ship_address1
    remove_column :order_items, :ship_address2
    remove_column :order_items, :ship_city
    remove_column :order_items, :ship_state
    remove_column :order_items, :ship_zipcode
    remove_column :order_items, :ship_country
    remove_column :order_items, :listings_type
    remove_column :order_items, :payment_type
    remove_column :order_items, :inperson_discount
    remove_column :order_items, :inperson_location
    remove_column :order_items, :etsy_fee
    remove_column :order_items, :notes
  end

  def down
    add_column :order_items, :buyer, :text
    add_column :order_items, :ship_name, :text
    add_column :order_items, :ship_address1, :text
    add_column :order_items, :ship_address2, :text
    add_column :order_items, :ship_city, :text
    add_column :order_items, :ship_state, :text
    add_column :order_items, :ship_zipcode, :text
    add_column :order_items, :ship_country, :text
    add_column :order_items, :listings_type, :string
    add_column :order_items, :payment_type, :string
    add_column :order_items, :inperson_discount, :text
    add_column :order_items, :inperson_location, :text
    add_column :order_items, :etsy_fee, :float
    add_column :order_items, :notes, :text
  end
end
