module ChartsProfitHelper
  require 'json'

  # Revenue By Month ###################################################################
  def get_revenue_array_by_months
    revenue_array = []
    get_months.each do |month|
      revenue_array.push(get_revenue_by_month(month))
    end
    return revenue_array
  end

  # Cost By Month ###################################################################
  def get_cost_array_by_months
    cost_array = []
    get_months.each do |month|
      cost_array.push(get_expenses_number_by_month(month))
    end
    return cost_array
  end
  
  # Profit By Month ###################################################################
  def get_profit_array_by_months
    profit_array = []
    get_months.each do |month|
      profit_array.push(get_profit_by_month(month))
    end
    return profit_array
  end



  # Revenue By Year ###################################################################
  def get_revenue_array_by_years
    revenue_array = []
    get_years.each do |year|
      revenue_array.push(get_revenue_by_year(year))
    end
    return revenue_array
  end

  # Cost By Year ###################################################################
  def get_cost_array_by_years
    cost_array = []
    get_years.each do |year|
      cost_array.push(get_expenses_number_by_year(year))
    end
    return cost_array
  end
  
  # Profit By Year ###################################################################
  def get_profit_array_by_years
    profit_array = []
    get_years.each do |year|
      profit_array.push(get_profit_by_year(year))
    end
    return profit_array
  end


end