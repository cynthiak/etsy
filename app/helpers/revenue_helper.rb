module RevenueHelper
  # Total Revenue ##############
  def get_revenue
    (Order.where(refund: nil).sum(:order_net) + Order.where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
  end

  def get_revenue_by_type(product_type)
    OrderItem.joins(:product).where(products: {product_type: product_type}).sum(:item_total).round(2)
  end

  # Average Revenue ##############
  def get_average_revenue
    (get_revenue/get_items_sold_count).round(2)
  end

  def get_average_revenue_by_type(product_type)
    (get_revenue_by_type(product_type)/get_items_sold_by_type_count(product_type)).round(2)
  end

  # Average Revenue Per ##############
  def get_average_revenue_per_order
    orders_count = Order.count
    (get_revenue/orders_count).round(2)
  end
  def get_average_revenue_per_order_item
    order_items_count = get_items_sold.sum(:quantity)
    (get_revenue/order_items_count).round(2)
  end

  # To Sell ##############
  def get_profit
    expenses = Expense.all.sum(:amount)
    revenue = get_revenue
    profit = (revenue - expenses).round(2)
  end
  def get_number_of_items_to_sell_by_type(product_type)
    (get_profit / get_average_revenue_by_type(product_type)).abs.ceil
  end

end