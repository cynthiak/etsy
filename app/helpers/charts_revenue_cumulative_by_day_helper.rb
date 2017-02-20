module ChartsRevenueCumulativeByDayHelper
  require 'json'

  # Cumulative Revenue By Day Of Month: Summary Series Only ########################
  def get_cumulative_revenue_by_day_of_month_series_summary
    revenue_by_day_of_month_series = []

    # Last year this month
    last_year_this_month = Date.new(get_last_sale_date.year - 1, get_last_sale_date.month, 1)
    last_year_this_month_revenue_by_day_of_month = []
    get_days_of_month_array_by_month(last_year_this_month).each do |day|
      last_year_this_month_revenue_by_day_of_month.push(get_cumulative_revenue_by_day_of_month(day, last_year_this_month))
    end
    revenue_by_day_of_month_series.push({
      'name' => last_year_this_month.strftime("%b %Y"), 
      'data' => last_year_this_month_revenue_by_day_of_month,
      'color' => '#E27AA0',
      'marker' => {
          'enabled' => false
        },
      'dashStyle' => 'ShortDot'
      })

    # Last 3 months
    previous_month = get_last_sale_date.prev_month
    previous_month = Date.new(previous_month.year, previous_month.month, 1)
    six_months_ago = previous_month - 2.months
    six_months_ago = Date.new(six_months_ago.year, six_months_ago.month, 1)
    get_months(six_months_ago, previous_month).each_with_index do |month, index|
      revenue_by_day_of_month = []
      get_days_of_month_array_by_month(month).each do |day|
        revenue_by_day_of_month.push(get_cumulative_revenue_by_day_of_month(day, month))
      end
      revenue_by_day_of_month_series.push({
        'name' => month.strftime("%b %Y"), 
        'data' => revenue_by_day_of_month,
        'lineWidth' => 1,
        'marker' => {
            'enabled' => false
          }
        })
    end

    # Current month
    current_month = Date.new(get_last_sale_date.year, get_last_sale_date.month, 1)
    current_month_revenue_by_day_of_month = []
    get_days_of_month_array_by_month(current_month).each do |day|
      current_month_revenue_by_day_of_month.push(get_cumulative_revenue_by_day_of_month(day, current_month))
    end
    revenue_by_day_of_month_series.push({
      'name' => current_month.strftime("%b %Y"), 
      'data' => current_month_revenue_by_day_of_month,
      'type' => 'column',
      'borderWidth' => 0,
      'color' => '#F0A4C0',
      'marker' => {
          'enabled' => false
        }
      })

    # Project current month's trajectory
    projected_revenue_by_day_of_month = []
    projected_revenue = 0.0
    get_days_of_month_array.each do |day|
      projected_revenue = projected_revenue + get_average_daily_revenue_by_month(current_month)
      projected_revenue_by_day_of_month.push(projected_revenue)
    end
    revenue_by_day_of_month_series.push({
    'name' => current_month.strftime("%b %Y Projected"), 
    'data' => projected_revenue_by_day_of_month,
    'type' => 'line',
    'dashStyle' => 'ShortDash',
    'lineWidth' => 2,
    'color' => '#BA0E4D',
    'marker' => {
        'enabled' => false
      }
    })

    # Ideal month
    ideal_month_revenue_by_day_of_month = []
    ideal_month_days_revenue = 0.0
    get_days_of_month_array.each do |day|
      ideal_month_days_revenue = ideal_month_days_revenue + get_daily_revenue_goal_by_month(current_month)
      ideal_month_revenue_by_day_of_month.push(ideal_month_days_revenue)
    end
    revenue_by_day_of_month_series.push({
    'name' => current_month.strftime("%b %Y Goal"), 
    'data' => ideal_month_revenue_by_day_of_month,
    'type' => 'line',
    'lineWidth' => 2,
    'color' => '#BA0E4D',
    'marker' => {
        'enabled' => false
      }
    })

    # TO DO: Get average 3 months
    # TO DO: Get average 6 months
    # TO DO: Get average 2015, 2016, 2017 revenue by day

    return revenue_by_day_of_month_series.to_json
  end

  # Cumulative Revenue By Day Of Month ################################
  def get_cumulative_revenue_by_day_of_month(day_of_month, month)
    start_date = month
    if Date.valid_date?(month.year, month.month, day_of_month)
      end_date = Date.new(month.year, month.month, day_of_month)
    else
      end_date = Date.civil(month.year, month.month, -1)
    end
    return (Order.where(refund: nil, sale_date: start_date..end_date).sum(:order_net) + Order.where(sale_date: start_date..end_date).where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
  end

end