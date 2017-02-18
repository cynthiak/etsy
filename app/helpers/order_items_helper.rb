module OrderItemsHelper

  # Sold Order Items ##############
  def get_items_sold(order_type=nil, start_date=nil, end_date=nil)
    if !start_date
      start_date = get_first_sale_date
    end
    if !end_date
      end_date = get_last_sale_date
    end

    if order_type
      order_items = OrderItem.joins(:order).where(orders: {order_type: order_type, sale_date: start_date..end_date})
    else
      order_items = OrderItem.joins(:order).where(orders: {sale_date: start_date..end_date})
    end
    return order_items
  end
  def get_items_sold_count(order_type=nil, start_date=nil, end_date=nil)
    get_items_sold(order_type, start_date, end_date).sum(:quantity)
  end
  def get_items_sold_count_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_items_sold_count(order_type, start_date, end_date)
  end
  def get_items_sold_count_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_items_sold_count(order_type, start_date, end_date)
  end

  # Unshipped Order Items ##############
  def get_unshipped_items(order_type=nil)
    if order_type
      OrderItem.joins(:order).where(orders: {order_type: order_type}).where(date_shipped: nil)
    else
      OrderItem.where(date_shipped: nil)
    end
  end

  def get_unshipped_items_count(order_type=nil)
    get_unshipped_items(order_type).sum(:quantity)
  end
end
