module ChartsHelper
  require 'json'

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

  # Cumulative Revenue By Day Of Month: Summary Series Only ##############
  def get_cumulative_revenue_by_day_of_month_series_summary
    revenue_by_day_of_month_series = []

    # Get last year this month's revenue by day
    last_year_this_month = Date.new(get_last_sale_date.year - 1, get_last_sale_date.month, 1)
    last_year_this_month_revenue_by_day_of_month = []
    get_days_of_month_array_by_month(last_year_this_month).each do |day|
      last_year_this_month_revenue_by_day_of_month.push(get_cumulative_revenue_by_day_of_month(day, last_year_this_month))
    end
    revenue_by_day_of_month_series.push({
      'name' => last_year_this_month.strftime("%b %Y"), 
      'data' => last_year_this_month_revenue_by_day_of_month,
      'marker' => {
          'enabled' => false
        },
      'dashStyle' => 'ShortDot'
      })

    # Get last 6 month's revenue by day
    previous_month = get_last_sale_date.prev_month
    previous_month = Date.new(previous_month.year, previous_month.month, 1)
    six_months_ago = previous_month - 5.months
    six_months_ago = Date.new(six_months_ago.year, six_months_ago.month, 1)
    get_months(six_months_ago, previous_month).each_with_index do |month, index|
      revenue_by_day_of_month = []
      get_days_of_month_array_by_month(month).each do |day|
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

    # Get current month's revenue by day
    current_month = Date.new(get_last_sale_date.year, get_last_sale_date.month, 1) # First of this month
    current_month_revenue_by_day_of_month = []
    get_days_of_month_array_by_month(current_month).each do |day|
      current_month_revenue_by_day_of_month.push(get_cumulative_revenue_by_day_of_month(day, current_month))
    end
    revenue_by_day_of_month_series.push({
      'name' => current_month.strftime("%b %Y"), 
      'data' => current_month_revenue_by_day_of_month,
      'type' => 'column',
      'borderWidth' => 0,
      'marker' => {
          'enabled' => false
        }
      })

    # Get average 3 months
    # Get average 6 months
    # Get average 2015, 2016, 2017 revenue by day


    return revenue_by_day_of_month_series.to_json
  end


  # Average Daily Revenue By Day ##############
  def get_last_x_dates_array(number_of_days=60)
    end_date = get_last_sale_date
    start_date = end_date - number_of_days
    last_x_dates_array = []
    while start_date != end_date do
      last_x_dates_array.push(start_date)
      start_date = start_date + 1
    end
    return last_x_dates_array
  end

  def get_last_x_dates_as_strings_array(number_of_days=60)
    end_date = get_last_sale_date
    start_date = end_date - number_of_days
    last_x_dates_array = []
    while start_date != end_date do
      last_x_dates_array.push(start_date.strftime("%b %d"))
      start_date = start_date + 1
    end
    return last_x_dates_array
  end

  def get_daily_revenue_chart_series(number_of_days=60)
    daily_revenue_chart_series = []

    # Last 30 Days: Column
    daily_revenue_array = []
    last_x_dates_array = get_last_x_dates_array(number_of_days)
    last_x_dates_array.each do |date|
      daily_revenue_array.push(get_revenue_by_day(nil, date))
    end
    daily_revenue_chart_series.push({
      'name' => 'Last ' + number_of_days.to_s + ' Days', 
      'data' => daily_revenue_array,
      'type' => 'column',
      'borderWidth' => 0
      })

    # Target For Current Month
    daily_revenue_target_array = []
    last_x_dates_array.each do |date|
      daily_revenue_target_array.push(get_daily_revenue_goal_by_month(get_last_sale_date))
    end
    daily_revenue_chart_series.push({
      'name' => get_last_sale_date.strftime("%b") + ' Revenue Target', 
      'data' => daily_revenue_target_array,
      'type' => 'line',
      'borderWidth' => 0,
      'lineWidth' => 1,
      'marker' => {
          'enabled' => false
        }
      })

    # Average For Current Month
    this_month_daily_average_revenue_array = []
    last_x_dates_array.each do |date|
      this_month_daily_average_revenue_array.push(get_average_daily_revenue_by_month(get_last_sale_date))
    end
    daily_revenue_chart_series.push({
      'name' => get_last_sale_date.strftime("%b") + ' Average', 
      'data' => this_month_daily_average_revenue_array,
      'type' => 'line',
      'borderWidth' => 0,
      'lineWidth' => 1,
      'marker' => {
          'enabled' => false
        }
      })




    return daily_revenue_chart_series.to_json
  end




end