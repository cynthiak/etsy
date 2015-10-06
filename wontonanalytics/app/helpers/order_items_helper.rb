module OrderItemsHelper
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
end
