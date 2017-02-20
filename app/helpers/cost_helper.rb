module CostHelper
  # Total Cost ##############
  def get_cost(order_type=nil, start_date=nil, end_date=nil)
    if !start_date
      start_date = get_first_sale_date
    end
    if !end_date
      end_date = get_last_sale_date
    end

    order_items = get_items_sold(order_type, start_date, end_date)
    
    cost = order_items.sum(:cost)

    return cost
  end
end