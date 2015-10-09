class DropSomeMoreColumnsFromOrderItems < ActiveRecord::Migration
  def up
    remove_column :order_items, :sale_date
    remove_column :order_items, :currency
    remove_column :order_items, :date_paid
    remove_column :order_items, :order_number
  end

  def down
    add_column :order_items, :sale_date, :date
    add_column :order_items, :currency, :string
    add_column :order_items, :date_paid, :date
    add_column :order_items, :order_number, :string
  end
end
