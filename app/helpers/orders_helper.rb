module OrdersHelper

  # Orders
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

  # Incomplete Orders
  def get_incomplete_orders_count(order_type=nil)
    get_unshipped_orders_count(order_type) + get_unpaid_orders_count(order_type)
  end


  # Unshipped Orders
  def get_unshipped_orders(order_type=nil)
    if order_type
      Order.where(order_type: order_type, date_shipped: nil).where.not(date_paid: nil)
    else
      Order.where(date_shipped: nil)
    end
  end
  def get_unshipped_orders_count(order_type=nil)
    get_unshipped_orders(order_type).count
  end


  # Completed Orders
  def get_completed_orders(order_type=nil)
    if order_type
      Order.where(order_type: order_type).where.not(date_shipped: nil, date_paid: nil)
    else
      Order.where.not(date_shipped: nil, date_paid: nil)
    end
  end

  # Unpaid Orders
  def get_unpaid_orders(order_type=nil)
    if order_type
      Order.where(order_type: order_type, date_paid: nil)
    else
      Order.where(date_paid: nil)
    end
  end
  def get_unpaid_orders_count(order_type=nil)
    get_unpaid_orders(order_type).count
  end


  # Average Items Per Order
  def get_average_items_per_order(order_type=nil)
    if order_type
      (get_items_sold_count(order_type, nil, nil)/get_orders_count(order_type)).round(0)
    else
      (get_items_sold_count/get_orders_count).round(0)
    end
  end
end
