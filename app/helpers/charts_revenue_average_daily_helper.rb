module ChartsRevenueAverageDailyHelper
  require 'json'

  # Average Daily Revenue By Day ##########################################
  def get_daily_revenue_vs_target_chart_series(number_of_days=60)
    daily_revenue_chart_series = []

    # Last 30 Days: Column
    daily_revenue_array = []
    last_x_dates_array = get_last_x_dates_array(number_of_days)
    last_x_dates_array.each do |date|
      difference = get_revenue_by_day(nil, date) - get_daily_revenue_goal_by_month(get_last_sale_date)
      daily_revenue_array.push(difference.round(2))
    end
    daily_revenue_chart_series.push({
      'name' => 'Last ' + number_of_days.to_s + ' Days', 
      'data' => daily_revenue_array,
      'type' => 'column',
      'borderWidth' => 0,
      'negativeColor' => '#FF6060',
      'color' => 'green'
      })

    # Average For Current Month
    this_month_daily_average_revenue_array = []
    last_x_dates_array.each do |date|
      difference = get_average_daily_revenue_by_month(get_last_sale_date) - get_daily_revenue_goal_by_month(get_last_sale_date)
      this_month_daily_average_revenue_array.push(difference.round(2))
    end
    daily_revenue_chart_series.push({
      'name' => get_last_sale_date.strftime("%b") + ' Average', 
      'data' => this_month_daily_average_revenue_array,
      'type' => 'line',
      'color' => 'black',
      'borderWidth' => 0,
      'lineWidth' => 1,
      'marker' => {
          'enabled' => false
        }
      })

    return daily_revenue_chart_series.to_json
  end




end