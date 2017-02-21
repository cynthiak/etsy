module ChartsOrdersHelper
  require 'json'

  # By Month ###################################################################
  def get_customers_array_by_months(customer_type=nil)
    customers_array = []
    get_months.each do |month|
      customers_array.push(get_customers_count_by_month(customer_type, month))
    end
    return customers_array.to_json
  end

  def get_revenue_per_customer_array_by_months(customer_type=nil)
    revenue_per_customer_array = []
    get_months.each do |month|
      revenue_per_customer_array.push(get_average_revenue_per_customer_by_month(customer_type, month))
    end
    return revenue_per_customer_array.to_json
  end




end