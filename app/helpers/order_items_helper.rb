module OrderItemsHelper

  # Sold Order Items ##############
  def get_items_sold(order_type=nil)
    if order_type
      OrderItem.joins(:order).where(orders: {order_type: order_type})
    else
      OrderItem.all
    end
  end

  def get_items_sold_count(order_type=nil)
    if order_type
      get_items_sold(order_type).sum(:quantity)
    else
      get_items_sold.sum(:quantity)
    end
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
    if order_type
      get_unshipped_items(order_type).sum(:quantity)
    else
      get_unshipped_items.sum(:quantity)
    end
  end
end
