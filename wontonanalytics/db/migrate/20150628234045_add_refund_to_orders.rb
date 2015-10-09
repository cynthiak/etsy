class AddRefundToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :refund, :float
  end
end
