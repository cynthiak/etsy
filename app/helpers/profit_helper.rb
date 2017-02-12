module ProfitHelper

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
  def get_average_daily_profit(start_date=nil, end_date=nil)
    (get_profit(start_date, end_date)/days(nil, start_date, end_date)).round(2)
  end

end