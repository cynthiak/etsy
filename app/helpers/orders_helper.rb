module OrdersHelper

  # Orders
  def get_orders(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    if order_type
      Order.where(order_type: order_type, sale_date: start_date..end_date)
    else
      Order.where(sale_date: start_date..end_date)
    end
  end
  def get_orders_count(order_type=nil, start_date=nil, end_date=nil)
    get_orders(order_type, start_date, end_date).count
  end
  def get_orders_count_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_orders_count(order_type, start_date, end_date)
  end
  def get_orders_count_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_orders_count(order_type, start_date, end_date)
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

end
