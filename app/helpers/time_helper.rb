module TimeHelper

  # Sales Dates ##############
  def get_first_sale_date(order_type=nil)
    if order_type != nil
      Order.where(order_type: order_type).order("sale_date").first.sale_date
    else
      Order.all.order("sale_date").first.sale_date
    end
  end

  def get_last_sale_date(order_type=nil)
    if order_type != nil
      Order.where(order_type: order_type).order("sale_date").last.sale_date
    else
      Order.all.order("sale_date").last.sale_date
    end
  end


  # Months ##############
  def months(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    if order_type
      orders = Order.where(order_type: order_type, sale_date: start_date..end_date).order("sale_date")
      if !orders.empty?
        start_date = orders.first.sale_date
        end_date = orders.last.sale_date
      else
        start_date = get_first_sale_date(order_type)
        end_date = get_last_sale_date(order_type)
      end
    else
      start_date = Order.where(sale_date: start_date..end_date).order("sale_date").first.sale_date
      end_date = Order.where(sale_date: start_date..end_date).order("sale_date").last.sale_date
    end
    return (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month) + 1
  end

  # Days ##############
  def days(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    if order_type
      orders = Order.where(order_type: order_type, sale_date: start_date..end_date).order("sale_date")
      if !orders.empty?
        start_date = orders.first.sale_date
        end_date = orders.last.sale_date
      else
        start_date = get_first_sale_date(order_type)
        end_date = get_last_sale_date(order_type)
      end
    else
      start_date = Order.where(sale_date: start_date..end_date).order("sale_date").first.sale_date
      end_date = Order.where(sale_date: start_date..end_date).order("sale_date").last.sale_date
    end
    return (end_date - start_date) + 1
  end

  
end