class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :orders, :order_id, :order_number
    rename_column :orders, :buyer_user_id, :username

    rename_column :order_items, :order_id, :order_number
  end
end
