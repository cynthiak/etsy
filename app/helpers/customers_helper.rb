module CustomersHelper
  def get_customers(customer_type=nil)
    if customer_type
      Customer.where(customer_type: customer_type)
    else
      Customer.all
    end
  end

  # Customer Count ##########
  def get_customers_count(customer_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date(customer_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(customer_type)
    end
    if customer_type
      return Order.where(order_type: customer_type, sale_date: start_date..end_date).pluck(:customer_id).uniq.count
    else
      return Order.where(sale_date: start_date..end_date).pluck(:customer_id).uniq.count
    end
  end
  def get_customers_count_by_month(customer_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_customers_count(customer_type, start_date, end_date)
  end

end