module OrdersHelper
  def get_orders(order_type=nil)
    if order_type
      Order.where(order_type: order_type)
    else
      Order.all
    end
  end
  def get_orders_count(order_type=nil)
    get_orders(order_type).count
  end
  def get_unshipped_orders(order_type=nil)
    if order_type
      Order.where(order_type: order_type, date_shipped: nil)
    else
      Order.where(date_shipped: nil)
    end
  end
  def get_unshipped_orders_count(order_type=nil)
    get_unshipped_orders(order_type).count
  end
  def get_shipped_orders(order_type=nil)
    if order_type
      Order.where(order_type: order_type).where.not(date_shipped: nil)
    else
      Order.where.not(date_shipped: nil)
    end
  end
  def get_average_items_per_order(order_type=nil)
    if order_type
      (get_items_sold_count(order_type)/get_orders_count(order_type)).round(0)
    else
      (get_items_sold_count/get_orders_count).round(0)
    end
  end
end
