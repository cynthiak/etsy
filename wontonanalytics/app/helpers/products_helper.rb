module ProductsHelper
  def get_sales_by_style_and_gender(style, gender)
  	OrderItem.joins(:variation).where(variations: {style: style, gender: gender}).sum(:quantity)
  end

  def get_revenue_by_style_and_gender(style, gender)
  	OrderItem.joins(:variation).where(variations: {style: style, gender: gender}).sum(:item_total)
  end
end
