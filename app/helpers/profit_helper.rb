module ProfitHelper

  # Profit ##############
  def get_profit(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    expenses = get_expenses(nil, start_date, end_date)
    revenue = get_revenue(nil, start_date, end_date)
    profit = (revenue - expenses).round(2)
  end
  def get_profit_by_year(year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_profit(start_date, end_date)
  end
  def get_profit_by_month(month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_profit(start_date, end_date)
  end


  def get_number_of_items_to_sell_by_type(product_type)
    (get_profit / product_type.get_average_revenue).abs.ceil
  end

  # Average Monthly ##############
  def get_average_monthly_profit(start_date=nil, end_date=nil)
    (get_profit(start_date, end_date)/months(nil, start_date, end_date)).round(2)
  end
  def get_average_monthly_profit_by_year(year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_average_monthly_profit(start_date, end_date)
  end

  # Average Daily ##############
  def get_average_daily_profit(start_date=nil, end_date=nil)
    (get_profit(start_date, end_date)/days(nil, start_date, end_date)).round(2)
  end
  def get_average_daily_profit_by_month(month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_average_daily_profit(start_date, end_date)
  end
  def get_average_daily_profit_by_year(year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_average_daily_profit(start_date, end_date)
  end

  # Profit percentage##############
  def get_profit_percentage_of_revenue
    profit = get_profit
    revenue = get_revenue
    return ((profit/revenue)*100).round(0)
  end
  def get_profit_percentage_of_revenue_by_year(year)
    profit = get_profit_by_year(year)
    revenue = get_revenue_by_year(nil, year)
    return ((profit/revenue)*100).round(0)
  end
  def get_profit_percentage_of_revenue_by_month(month)
    profit = get_profit_by_month(month)
    revenue = get_revenue_by_month(month)
    return ((profit/revenue)*100).round(0)
  end



end