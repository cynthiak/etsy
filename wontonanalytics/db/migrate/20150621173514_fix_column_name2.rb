class FixColumnName2 < ActiveRecord::Migration
  def change
    rename_column :order_items, :transaction_id, :transaction_number
    rename_column :order_items, :listing_id, :listing_number
  end
end
