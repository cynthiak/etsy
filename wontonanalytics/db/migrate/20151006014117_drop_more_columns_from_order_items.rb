class DropMoreColumnsFromOrderItems < ActiveRecord::Migration
  def up
    remove_column :order_items, :order_shipping
    remove_column :order_items, :order_sales_tax
  end

  def down
    add_column :order_items, :order_shipping, :float
    add_column :order_items, :order_sales_tax, :float
  end
end
