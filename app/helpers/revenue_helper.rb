module RevenueHelper

  # Total Revenue ##############
  def get_revenue(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    if order_type
      (Order.where(adjusted_net_order_amount: nil, order_type: order_type, sale_date: start_date..end_date).sum(:order_net) + Order.where.not(adjusted_net_order_amount:nil).where(order_type: order_type, sale_date: start_date..end_date).sum(:adjusted_net_order_amount)).round(2)
    else
      (Order.where(adjusted_net_order_amount: nil, sale_date: start_date..end_date).sum(:order_net) + Order.where.not(adjusted_net_order_amount:nil).where(sale_date: start_date..end_date).sum(:adjusted_net_order_amount)).round(2)
    end
  end

  # Percentage Revenue ##############
  def get_revenue_percentage(order_type=nil, start_date=nil, end_date=nil)
    ((get_revenue(order_type, start_date, end_date)/get_revenue)*100).round(0)
  end


  # Average Revenue ##############
  def get_average_revenue_per_item(order_type=nil)
    (get_revenue(order_type)/get_items_sold_count(order_type)).round(2)
  end
  def get_average_monthly_revenue(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    (get_revenue(order_type, start_date, end_date)/months(order_type, start_date, end_date)).round(2)
  end
  def get_average_monthly_revenue_percentage(order_type=nil, start_date=nil, end_date=nil)
    (get_average_monthly_revenue(order_type, start_date, end_date)/(get_average_monthly_revenue(nil, start_date, end_date))*100).round(0)
  end

  # Average Revenue Per ##############
  def get_average_revenue_per_order(order_type=nil)
    orders_count = get_orders_count(order_type)
    (get_revenue(order_type)/orders_count).round(2)
  end

  def get_average_revenue_per_order_item(order_type=nil)
    (get_revenue(order_type)/get_items_sold_count(order_type)).round(2)
  end

  def get_average_revenue_per_customer(order_type=nil)
    (get_revenue(order_type)/get_customers_count(order_type)).round(2)
  end


  # Profit ##############
  def get_profit(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    expenses = get_expenses_number(start_date, end_date)
    revenue = get_revenue(nil, start_date, end_date)
    profit = (revenue - expenses).round(2)
  end
  def get_number_of_items_to_sell_by_type(product_type)
    (get_profit / product_type.get_average_revenue).abs.ceil
  end
  def get_average_monthly_profit(start_date=nil, end_date=nil)
    (get_profit(start_date, end_date)/months(nil, start_date, end_date)).round(2)
  end

end