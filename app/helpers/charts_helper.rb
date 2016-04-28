module ChartsHelper
  require 'json'

  # Months ##############
  def get_months_array
    date_from  = Date.parse('2015-4-1')
    date_to    = Date.today
    date_range = date_from..date_to

    date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    date_months.map {|d| d.strftime "%b %Y" }
  end

  def get_months
    date_from  = Date.parse('2015-4-1')
    date_to    = Date.today
    date_range = date_from..date_to

    date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    return date_months
  end

  # Revenue By Month ##############
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

  # Cost By Month ##############
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
  
  # Profit By Month ##############
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



  # Days ##############
  def get_days_of_month_array
    Array(1...32)
  end

  # Cumulative Revenue By Day Of Month ##############
  def get_cumulative_revenue_by_day_of_month(day_of_month, month)
    start_date = month
    if Date.valid_date?(month.year, month.month, day_of_month)
      end_date = Date.new(month.year, month.month, day_of_month)
    else
      end_date = Date.civil(month.year, month.month, -1)
    end
    return (Order.where(refund: nil, sale_date: start_date..end_date).sum(:order_net) + Order.where(sale_date: start_date..end_date).where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
  end

  def get_cumulative_revenue_by_day_of_month_series
    revenue_by_day_of_month_series = []
    
    get_months.each do |month|
      revenue_by_day_of_month = []
      get_days_of_month_array.each do |day|
        revenue_by_day_of_month.push(get_cumulative_revenue_by_day_of_month(day, month))
      end
      revenue_by_day_of_month_series.push({
        'name' => month.strftime("%b %Y"), 
        'data' => revenue_by_day_of_month,
        'marker' => {
            'enabled' => false
          }
        })
    end
    return revenue_by_day_of_month_series.to_json
  end




end