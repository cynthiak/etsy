module ChartsProductsHelper
  require 'json'

  # Margin By Month ###################################################################
  def get_product_type_revenue_array_by_months
    product_type_revenue_array_series = []
    product_types = ["Planner Stickers", "Washi", "Card", "Laptop Sticker", "Stamps", "Notebooks"]

    product_types.each do |product_type|
      product_type_revenue_by_month = []
      get_months.each do |month|
        product_type_revenue_by_month.push(get_margin_by_month(order_type, month).round(2))
      end
      product_type_revenue_array_series.push({
        'name' => product_type, 
        'data' => product_type_revenue_by_month,
        'marker' => {
            'enabled' => false
          }
        })
    end


    return product_type_revenue_array
  end

end