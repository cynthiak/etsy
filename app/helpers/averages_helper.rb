module AveragesHelper

  # Average Revenue Per Customer ##############
  def get_average_revenue_per_customer(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    return (get_revenue(order_type, start_date, end_date)/get_customers_count(order_type, start_date, end_date)).round(2)
  end
  def get_average_revenue_per_customer_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_average_revenue_per_customer(order_type, start_date, end_date)
  end
  def get_average_revenue_per_customer_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.new(year, 12, 31)
    return get_average_revenue_per_customer(order_type, start_date, end_date)
  end

  # Average Revenue Per Order ##############
  def get_average_revenue_per_order(order_type=nil, start_date=nil, end_date=nil)
    orders_count = get_orders_count(order_type, start_date, end_date)
    return (get_revenue(order_type, start_date, end_date)/orders_count).round(2)
  end
  def get_average_revenue_per_order_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_average_revenue_per_order(order_type, start_date, end_date)
  end
  def get_average_revenue_per_order_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.new(year, 12, 31)
    return get_average_revenue_per_order(order_type, start_date, end_date)
  end

    # Average Revenue Per Order Item ##############
  def get_average_revenue_per_order_item(order_type=nil, start_date=nil, end_date=nil)
    (get_revenue(order_type, start_date, end_date)/get_items_sold_count(order_type, start_date, end_date)).round(2)
  end
  def get_average_revenue_per_order_item_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_average_revenue_per_order_item(order_type, start_date, end_date)
  end
  def get_average_revenue_per_order_item_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.new(year, 12, 31)
    return get_average_revenue_per_order_item(order_type, start_date, end_date)
  end

  # Average Orders Per Customer #######
  def get_average_orders_per_customer(customer_type=nil)
    (get_orders_count(customer_type, nil, nil)/get_customers_count(customer_type, nil, nil)).round(0)
  end

  # Average Order Items Per Customer #######
  def get_average_order_items_per_customer(customer_type=nil)
    (get_items_sold_count(customer_type, nil, nil)/get_customers_count(customer_type, nil, nil)).round(0)
  end

  # Average Items Per Order #######
  def get_average_items_per_order(order_type=nil, start_date=nil, end_date=nil)
    if get_orders_count(order_type, start_date, end_date) > 0
      (get_items_sold_count(order_type, start_date, end_date)/get_orders_count(order_type, start_date, end_date)).round(0)
    else
      0
    end
  end
  def get_average_items_per_order_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_average_items_per_order(order_type, start_date, end_date)
  end
  def get_average_items_per_order_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.new(year, 12, 31)
    return get_average_items_per_order(order_type, start_date, end_date)
  end

end