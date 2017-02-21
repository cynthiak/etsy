module GoalsHelper

  # BY YEAR
  def get_revenue_goal_by_year(year)
    goal = 0.00
    if year == 2015
      goal = 8000
    elsif year == 2016
      goal = 40000
    elsif year == 2017
      goal = 80000
    else
      goal = 0.00
    end
    return goal
  end

  def get_percentage_achieved_by_year(year)
    revenue = get_revenue_by_year(nil, year)
    goal = get_revenue_goal_by_year(year)
    percentage = ((revenue/goal)*100).round(1)
    return percentage
  end

  def get_daily_revenue_goal_by_year(year)
    if year == 2015
      days = 275
    else
      days = 365
    end
    goal = get_revenue_goal_by_year(year)
    return (goal/days).round(2)
  end

  def get_daily_percentage_achieved_for_year_by_month(date)
    revenue = get_average_daily_revenue_by_month(date)
    goal = get_daily_revenue_goal_by_year(date.year)
    percentage = ((revenue/goal)*100).round(1)
    return percentage
  end

  def get_daily_percentage_achieved_for_year(year)
    revenue = get_average_daily_revenue_by_year(year)
    goal = get_daily_revenue_goal_by_year(year)
    percentage = ((revenue/goal)*100).round(1)
    return percentage
  end

  # BY MONTH

  def get_revenue_goal_by_month(date)
    if date.year == 2015
      months = 10
    else
      months = 12
    end
    year_revenue_goal = get_revenue_goal_by_year(date.year)
    return (year_revenue_goal/months).round(0)
  end

  def get_percentage_achieved_for_month(date)
    revenue = get_revenue_by_month(nil, date)
    goal = get_revenue_goal_by_month(date)
    percentage = ((revenue/goal)*100).round(1)
    return percentage
  end

  def get_daily_revenue_goal_by_month(date)
    days = date.end_of_month.day
    goal = get_revenue_goal_by_month(date)
    return (goal/days).round(2)
  end

  def get_daily_percentage_achieved_for_month(date)
    revenue = get_average_daily_revenue_by_month(date)
    goal = get_daily_revenue_goal_by_month(date)
    percentage = ((revenue/goal)*100).round(1)
    return percentage
  end


  # ADJUSTED GOALS
  def get_adjusted_year_revenue_goal # excludes this month
    today = get_last_sale_date
    last_month = today - 1.month
    last_day = Date.civil(last_month.year, last_month.month, -1)
    first_day_of_year = Date.new(today.year, 1, 1)
    rest_of_year_revenue_goal = get_revenue_goal_by_year(today.year) - get_revenue(nil, first_day_of_year, last_day)
    return rest_of_year_revenue_goal
  end
  def get_adjusted_monthly_revenue_goal # rest of year
    months = get_months_left_in_year.count
    rest_of_year_revenue_goal = get_adjusted_year_revenue_goal
    return (rest_of_year_revenue_goal/months).round(2)
  end

  def get_adjusted_daily_revenue_goal # rest of year
    days = get_days_left_in_year_count
    today = get_last_sale_date
    rest_of_year_revenue_goal = get_adjusted_year_revenue_goal
    return (rest_of_year_revenue_goal/days).round(2)
  end

  # BY DAY
  def get_percentage_goal_by_day_of_month(date)
    daily_revenue_goal = get_daily_revenue_goal_by_month(date)
    month_revenue_goal = get_revenue_goal_by_month(date)
    today = date.day
    target = daily_revenue_goal*today
    return ((target / month_revenue_goal)*100).round(1)
  end

end