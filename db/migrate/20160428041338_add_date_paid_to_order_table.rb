class AddDatePaidToOrderTable < ActiveRecord::Migration
  def self.up
    add_column :orders, :date_paid, :date
  end

  def self.down
    remove_column :orders, :date_paid
  end
end
