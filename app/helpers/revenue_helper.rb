module RevenueHelper
  # Total Revenue ##############
  def get_revenue(order_type=nil)
    if order_type
      (Order.where(refund: nil, order_type: order_type).sum(:order_net) + Order.where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
    else
      (Order.where(refund: nil).sum(:order_net) + Order.where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
    end
  end

  # Average Revenue ##############
  def get_average_revenue_per_item(order_type=nil)
    (get_revenue(order_type)/get_items_sold_count(order_type)).round(2)
  end
  def get_average_monthly_revenue
    (get_revenue/months).round(2)
  end

  # Average Revenue Per ##############
  def get_average_revenue_per_order(order_type=nil)
    orders_count = get_orders_count(order_type)
    (get_revenue(order_type)/orders_count).round(2)
  end

  def get_average_revenue_per_order_item(order_type=nil)
    (get_revenue(order_type)/get_items_sold_count(order_type)).round(2)
  end

  def get_average_revenue_per_customer(order_type=nil)
    (get_revenue(order_type)/get_customers_count(order_type)).round(2)
  end

  # Months ##############
  def months
    first_date = Order.all.order("sale_date").first.sale_date
    last_date = Order.all.order("sale_date").last.sale_date
    return (last_date.year * 12 + last_date.month) - (first_date.year * 12 + first_date.month)
  end


  # Profit ##############
  def get_profit
    expenses = Expense.all.sum(:amount)
    revenue = get_revenue
    profit = (revenue - expenses).round(2)
  end
  def get_number_of_items_to_sell_by_type(product_type)
    (get_profit / product_type.get_average_revenue).abs.ceil
  end
  def get_average_monthly_profit
    (get_profit/months).round(2)
  end

end