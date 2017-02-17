module ChartsProfitHelper
  require 'json'

  # Revenue By Month ###################################################################
  def get_revenue_by_month(month)
    start_date = month
    end_date = Date.civil(month.year, month.month, -1)
    return (Order.where(adjusted_net_order_amount: nil, sale_date: start_date..end_date).sum(:order_net) + Order.where.not(adjusted_net_order_amount:nil).where(sale_date: start_date..end_date).sum(:adjusted_net_order_amount)).round(2)
  end

  def get_revenue_array_by_months
    revenue_array = []
    get_months.each do |month|
      revenue_array.push(get_revenue_by_month(month))
    end
    return revenue_array
  end

  # Cost By Month ###################################################################
  def get_cost_by_month(month)
    start_date = month
    end_date = Date.civil(month.year, month.month, -1)
    
    return Expense.where(date: start_date..end_date).sum(:amount).round(2)
  end

  def get_cost_array_by_months
    cost_array = []
    get_months.each do |month|
      cost_array.push(get_cost_by_month(month))
    end
    return cost_array
  end
  
  # Profit By Month ###################################################################
  def get_profit_by_month(month)
    return (get_revenue_by_month(month) - get_cost_by_month(month)).round(2)
  end

  def get_profit_array_by_months
    profit_array = []
    get_months.each do |month|
      profit_array.push(get_profit_by_month(month))
    end
    return profit_array
  end
end