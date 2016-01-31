module OrdersHelper
  def get_orders
    Order.all
  end
  def get_orders_count
    Order.count
  end
  def get_unshipped_orders
    Order.where(date_shipped: nil)
  end
  def get_unshipped_orders_count
    get_unshipped_orders.count
  end
  def get_shipped_orders
    Order.where.not(date_shipped: nil)    
  end
  def get_average_items_per_order
    (get_items_sold_count/get_orders_count).round(2)
  end
end
