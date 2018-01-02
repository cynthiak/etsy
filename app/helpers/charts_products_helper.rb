module ChartsProductsHelper
  require 'json'

  # Revenue By Month ###################################################################
  def get_product_type_revenue_array_by_months
    product_type_revenue_array_series = []
    product_types = ["Planner Stickers", "Washi", "Cards", "Laptop Stickers", "Stamps", "Notebooks", "Keychains", "Bundles"]

    product_types.each do |product_type|
      product_type_revenue_by_month = []
      product_type_object = ProductType.find_by(product_type: product_type)
      get_months.each do |month|
        product_type_revenue_by_month.push(product_type_object.get_revenue_by_month(month).round(2))
      end
      product_type_revenue_array_series.push({
        'name' => product_type, 
        'data' => product_type_revenue_by_month,
        'marker' => {
            'enabled' => false
          }
        })
    end

    return product_type_revenue_array_series.to_json
  end

  # Margin By Month ###################################################################
  def get_product_type_margin_array_by_months
    product_type_margin_array_series = []
    product_types = ["Planner Stickers", "Washi", "Cards", "Laptop Stickers", "Stamps", "Notebooks", "Keychains", "Bundles"]

    product_types.each do |product_type|
      product_type_margin_by_month = []
      product_type_object = ProductType.find_by(product_type: product_type)
      get_months.each do |month|
        product_type_margin_by_month.push(product_type_object.get_margin_by_month(month).round(2))
      end
      product_type_margin_array_series.push({
        'name' => product_type, 
        'data' => product_type_margin_by_month,
        'marker' => {
            'enabled' => false
          }
        })
    end

    return product_type_margin_array_series.to_json
  end

  # Items Sold By Month ###################################################################
  def get_product_type_items_sold_array_by_months
    product_type_items_sold_array_series = []
    product_types = ["Planner Stickers", "Washi", "Cards", "Laptop Stickers", "Stamps", "Notebooks", "Keychains", "Bundles"]

    product_types.each do |product_type|
      product_type_items_sold_by_month = []
      product_type_object = ProductType.find_by(product_type: product_type)
      get_months.each do |month|
        product_type_items_sold_by_month.push(product_type_object.get_order_items_count_by_month(month).round(2))
      end
      product_type_items_sold_array_series.push({
        'name' => product_type, 
        'data' => product_type_items_sold_by_month,
        'marker' => {
            'enabled' => false
          }
        })
    end

    return product_type_items_sold_array_series.to_json
  end

end