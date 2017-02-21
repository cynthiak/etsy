module ProductsHelper


  # Product Types #################
  def get_product_types
    ProductType.all.order('product_type ASC')
  end

  def get_product_types_count
    get_product_types.count
  end

  # Products #################
  def get_products(product_type=nil)
    if product_type
      product_type_object = ProductType.where(product_type: product_type)
      Product.where(product_type: product_type_object)
    else
      Product.all
    end
  end
  def get_products_count(product_type=nil)
    get_products(product_type).count
  end

  # Sold #################
  def get_items_sold_by_variation(variation)
    OrderItem.joins(:variation).where(variation: variation).sum(:quantity)
  end

  def get_items_sold_by_style_and_gender(style, gender)
  	OrderItem.joins(:variation).where(variations: {style: style, gender: gender}).sum(:quantity)
  end

  # Revenue #################
  def get_revenue_by_product_type(product_type)
    product_type.get_revenue
  end
  def get_revenue_by_product_type_by_month(product_type, month)
  end


  def get_revenue_by_variation(variation)
    OrderItem.joins(:variation).where(variation: variation).sum(:item_total)
  end

  def get_revenue_by_style_and_gender(style, gender)
  	OrderItem.joins(:variation).where(variations: {style: style, gender: gender}).sum(:item_total)
  end
end