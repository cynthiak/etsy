module MarginHelper
  # Total Margin ##############
  def get_margin(order_type=nil, start_date=nil, end_date=nil)
    revenue = get_revenue(order_type, start_date, end_date)
    cost = get_cost(order_type, start_date, end_date)
    margin = revenue - cost
    return margin
  end

  def get_margin_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_margin(order_type, start_date, end_date)
  end
  def get_margin_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_margin(order_type, start_date, end_date)
  end

  # Breakdown of Margin By Order Type ##############
  def get_percentage_of_margin_that_is_order_type(order_type, start_date=nil, end_date=nil)
    order_type_margin = get_margin(order_type, start_date, end_date)
    total_margin = get_margin(nil, start_date, end_date)

    return ((order_type_margin/total_margin)*100).round(0)
  end
  def get_percentage_of_margin_that_is_order_type_by_month(order_type, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_percentage_of_margin_that_is_order_type(order_type, start_date, end_date)
  end
  def get_percentage_of_margin_that_is_order_type_by_year(order_type, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_percentage_of_margin_that_is_order_type(order_type, start_date, end_date)
  end

  # Percentage Margin ##############
  def get_margin_percentage(order_type=nil, start_date=nil, end_date=nil)
    if !start_date
      start_date = get_first_sale_date
    end
    if !end_date
      end_date = get_last_sale_date
    end

    revenue = get_revenue(order_type, start_date, end_date)
    margin = get_margin(order_type, start_date, end_date)

    margin_percentage = ((margin/revenue)*100).round(2)

    return margin_percentage
  end

  def get_margin_percentage_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_margin_percentage(order_type, start_date, end_date)
  end

  def get_margin_percentage_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_margin_percentage(order_type, start_date, end_date)
  end

  # Average Margin Per Item ##############
  def get_average_margin_per_item(order_type=nil, start_date=nil, end_date=nil)
    margin = get_margin(order_type, start_date, end_date)
    items_sold = get_items_sold_count(order_type, start_date, end_date)

    return (margin/items_sold).round(2)
  end
  def get_average_margin_per_item_by_month(order_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_average_margin_per_item(order_type, start_date, end_date)
  end
  def get_average_margin_per_item_by_year(order_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_average_margin_per_item(order_type, start_date, end_date)
  end
  




end