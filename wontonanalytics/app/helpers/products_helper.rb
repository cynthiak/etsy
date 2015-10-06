module ProductsHelper
  def get_product_types
    Product.order(:product_type).pluck(:product_type).uniq
  end

  def get_products_by_type(product_type)
    Product.where(product_type: product_type)
  end

  def product_type_slug(product_type)
    product_type.delete(' ')
  end

  def get_sales_by_style_and_gender(style, gender)
  	OrderItem.joins(:variation).where(variations: {style: style, gender: gender}).sum(:quantity)
  end

  def get_revenue_by_style_and_gender(style, gender)
  	OrderItem.joins(:variation).where(variations: {style: style, gender: gender}).sum(:item_total)
  end
end
