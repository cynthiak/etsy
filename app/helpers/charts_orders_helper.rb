module ChartsOrdersHelper
  require 'json'

  # Revenue Per Customer ########################################################
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

  # Revenue Per Order ########################################################
  def get_orders_array_by_months(order_type=nil)
    orders_array = []
    get_months.each do |month|
      orders_array.push(get_orders_count_by_month(order_type, month))
    end
    return orders_array.to_json
  end

  def get_revenue_per_order_array_by_months(order_type=nil)
    revenue_per_order_array = []
    get_months.each do |month|
      revenue_per_order_array.push(get_average_revenue_per_order_by_month(order_type, month))
    end
    return revenue_per_order_array.to_json
  end

  # Revenue Per Order Item ########################################################
  def get_order_items_array_by_months(order_type=nil)
    orders_array = []
    get_months.each do |month|
      orders_array.push(get_items_sold_count_by_month(order_type, month))
    end
    return orders_array.to_json
  end

  def get_revenue_per_order_item_array_by_months(order_type=nil)
    revenue_per_order_item_array = []
    get_months.each do |month|
      revenue_per_order_item_array.push(get_average_revenue_per_order_item_by_month(order_type, month))
    end
    return revenue_per_order_item_array.to_json
  end

  # Order Items Per Order ########################################################
  def get_order_items_per_order_array_by_months(order_type=nil)
    order_items_per_order_array = []
    get_months.each do |month|
      order_items_per_order_array.push(get_average_items_per_order_by_month(order_type, month))
    end
    return order_items_per_order_array.to_json
  end


end