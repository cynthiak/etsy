class AddColumnsToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :order_id, :integer
    add_column :expenses, :order_item_id, :integer
    add_index 'expenses', ['order_id'], :name => 'order_id'
    add_index 'expenses', ['order_item_id'], :name => 'order_item_id'
  end

  def self.down
    remove_column :expenses, :order_id
    remove_column :expenses, :order_item_id
  end
end
