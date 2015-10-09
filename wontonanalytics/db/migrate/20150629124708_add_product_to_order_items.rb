class AddProductToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :product_id, :integer
    add_index 'order_items', ['product_id'], :name => 'index_product_id3'

    add_column :order_items, :variation_id, :integer
    add_index 'order_items', ['variation_id'], :name => 'index_variation_id2'
  end

  def self.down
    remove_column :order_items, :product_id
    remove_column :order_items, :variation_id
  end
end
