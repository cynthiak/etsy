module ChartsCumulativeByMonthHelper
  require 'json'

  # Cumulative Revenue By Day Of Month: Summary Series Only ########################
  def get_cumulative_revenue_by_month_of_year_series
    revenue_by_month_of_year_series = []
    today = get_last_sale_date

    # Previous Years
    years = get_years
    years.delete(today.year)
    years.each do |year|
      revenue_by_month_of_year = []
      get_months_by_year(year).each do |month|
        revenue_by_month_of_year.push(get_cumulative_revenue_month_of_year(month))
      end
      revenue_by_month_of_year_series.push({
        'name' => year, 
        'data' => revenue_by_month_of_year,
        'lineWidth' => 1,
        'marker' => {
            'enabled' => false
          }
        })
    end
    
    # Current Year
    current_year_revenue_by_month = []
    get_months_by_year(today.year).each do |month|
      current_year_revenue_by_month.push(get_cumulative_revenue_month_of_year(month))
    end
    revenue_by_month_of_year_series.push({
      'name' => today.year, 
      'data' => current_year_revenue_by_month,
      'type' => 'column',
      'borderWidth' => 0,
      'color' => '#E27AA0',
      'marker' => {
          'enabled' => false
        }
      })

    # Project Current Year
    projected_revenue_by_month = []
    projected_revenue = 0.0
    this_year_first_day = 
    this_year_months = get_months(Date.new(today.year, 1, 1), Date.new(today.year, 12, 31))
    this_year_months.each do |month|
      projected_revenue = projected_revenue + get_average_monthly_revenue_by_month(nil, today)
      projected_revenue_by_month.push(projected_revenue)
    end
    revenue_by_month_of_year_series.push({
    'name' => today.strftime("%Y Projected"), 
    'data' => projected_revenue_by_month,
    'type' => 'line',
    'dashStyle' => 'ShortDash',
    'lineWidth' => 2,
    'color' => '#BA0E4D',
    'marker' => {
        'enabled' => false
      }
    })


    # Project Current Year Ideal Trajectory
    ideal_revenue_by_month = []
    ideal_revenue = 0.0
    this_year_months.each do |month|
      ideal_revenue = ideal_revenue + get_revenue_goal_by_month(today)
      ideal_revenue_by_month.push(ideal_revenue)
    end
    revenue_by_month_of_year_series.push({
    'name' => today.strftime("%Y Goal"), 
    'data' => ideal_revenue_by_month,
    'type' => 'line',
    'lineWidth' => 2,
    'color' => '#BA0E4D',
    'marker' => {
        'enabled' => false
      }
    })



    return revenue_by_month_of_year_series.to_json
  end


  # Cumulative Revenue By Month Of Year ################################
  def get_cumulative_revenue_month_of_year(month)
    start_date = Date.civil(month.year, 1, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return (Order.where(refund: nil, sale_date: start_date..end_date).sum(:order_net) + Order.where(sale_date: start_date..end_date).where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
  end



end



# current_month = Date.new(get_last_sale_date.year, get_last_sale_date.month, 1)
# current_month_revenue_by_day_of_month = []
# get_days_of_month_array_by_month(current_month).each do |day|
#   current_month_revenue_by_day_of_month.push(get_cumulative_revenue_by_day_of_month(day, current_month))
# end
# revenue_by_day_of_month_series.push({
#   'name' => current_month.strftime("%b %Y"), 
#   'data' => current_month_revenue_by_day_of_month,
#   'type' => 'column',
#   'borderWidth' => 0,
#   'color' => '#E27AA0',
#   'marker' => {
#       'enabled' => false
#     }
#   })