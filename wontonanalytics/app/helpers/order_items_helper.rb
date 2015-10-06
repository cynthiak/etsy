module OrderItemsHelper

  # Sold Order Items ##############
  def get_all_items_sold
    OrderItem.all
  end

  def get_all_items_sold_count
    get_all_items_sold.sum(:quantity)
  end

  def get_items_sold_by_type(product_type)
    OrderItem.joins(:product).where(products: {product_type: product_type})
  end

  def get_items_sold_by_type_count(product_type)
    get_items_sold_by_type(product_type).sum(:quantity)
  end


  # Shipped Order Items ##############
  def get_all_items_to_ship
    OrderItem.where(date_shipped: nil)
  end

  def get_all_items_to_ship_count
    get_all_items_to_ship.sum(:quantity)
  end

  def get_items_to_ship_by_type(product_type)
    OrderItem.joins(:product).where(products: {product_type: product_type}).where(date_shipped: nil)
  end

  def get_items_to_ship_by_type_count(product_type)
    get_items_to_ship_by_type(product_type).sum(:quantity)
  end


  # Total Revenue ##############
  def get_total_revenue
    (Order.where(refund: nil).sum(:order_net) + Order.where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
  end

  def get_revenue_by_type(product_type)
    OrderItem.joins(:product).where(products: {product_type: product_type}).sum(:item_total).round(2)
  end

  # Average Revenue ##############
  def get_average_revenue
    (get_total_revenue/get_all_items_sold_count).round(2)
  end

  def get_average_revenue_by_type(product_type)
    (get_revenue_by_type(product_type)/get_items_sold_by_type_count(product_type)).round(2)
  end

end
