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
  def get_revenue_by_year(year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.new(year, 12, 31)
    return get_revenue(nil, start_date, end_date)
  end
  def get_revenue_by_month(month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_revenue(nil, start_date, end_date)
  end
  def get_revenue_by_day(order_type=nil, date)
    if order_type
      (Order.where(adjusted_net_order_amount: nil, order_type: order_type, sale_date: date).sum(:order_net) + Order.where.not(adjusted_net_order_amount:nil).where(order_type: order_type, sale_date: date).sum(:adjusted_net_order_amount)).round(2)
    else
      (Order.where(adjusted_net_order_amount: nil, sale_date: date).sum(:order_net) + Order.where.not(adjusted_net_order_amount:nil).where(sale_date: date).sum(:adjusted_net_order_amount)).round(2)
    end
  end

  # Percentage Revenue ##############
  def get_revenue_percentage(order_type=nil, start_date=nil, end_date=nil)
    ((get_revenue(order_type, start_date, end_date)/get_revenue)*100).round(0)
  end

  # Average Monthly Rev ##############
  def get_average_monthly_revenue(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    (get_revenue(order_type, start_date, end_date)/months(order_type, start_date, end_date)).round(2)
  end
  def get_average_monthly_revenue_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_average_monthly_revenue(order_type, start_date, end_date)
  end
  def get_average_monthly_revenue_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_average_monthly_revenue(order_type, start_date, end_date)
  end

  # Average Monthly Rev Percentage ##############
  def get_average_monthly_revenue_percentage(order_type=nil, start_date=nil, end_date=nil)
    (get_average_monthly_revenue(order_type, start_date, end_date)/(get_average_monthly_revenue(nil, start_date, end_date))*100).round(0)
  end

  # Average Daily Rev ##############
  def get_average_daily_revenue(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    (get_revenue(order_type, start_date, end_date)/days(order_type, start_date, end_date)).round(2)
  end

  # Average Daily Rev Percentage##############
  def get_average_daily_revenue_percentage(order_type=nil, start_date=nil, end_date=nil)
    (get_average_daily_revenue(order_type, start_date, end_date)/(get_average_daily_revenue(nil, start_date, end_date))*100).round(0)
  end
  def get_average_daily_revenue_by_year(order_type=nil, year)
    start_date = get_first_sale_date_in_year(order_type, year)
    end_date = get_last_sale_date_in_year(order_type, year)
    get_average_daily_revenue(order_type, start_date, end_date)
  end
  def get_average_daily_revenue_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    get_average_daily_revenue(order_type, start_date, end_date)
  end


  # Funds ##############
  def get_funds
    Fund.all.sum(:funding_amount)
  end
  def get_total_funds
    Fund.all.sum(:funding_amount) + get_profit
  end

end