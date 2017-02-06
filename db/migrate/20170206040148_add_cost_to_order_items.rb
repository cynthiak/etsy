class AddCostToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :cost, :float

    OrderItem.find_each do |order_item|
      if order_item.product
        cost = order_item.product.cost
        if cost
          cost = cost * order_item.quantity
          order_item.update_column(:cost, cost)
        end
      end
    end
  end

  def self.down
    remove_column :order_items, :cost
  end
end
