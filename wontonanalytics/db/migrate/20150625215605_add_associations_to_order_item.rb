class AddAssociationsToOrderItem < ActiveRecord::Migration
  def self.up
    add_column :order_items, :order_id, :integer
    add_index 'order_items', ['order_id'], :name => 'index_order_id'

    add_column :order_items, :listing_id, :integer
    add_index 'order_items', ['listing_id'], :name => 'index_listing_id'
  end

  def self.down
    remove_column :order_items, :order_id
    remove_column :order_items, :listing_id
  end
end
