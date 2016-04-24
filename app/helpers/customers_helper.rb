module CustomersHelper
  def get_customers(customer_type=nil)
    if customer_type
      Customer.where(customer_type: customer_type)
    else
      Customer.all
    end
  end
  def get_customers_count(customer_type=nil)
    get_customers(customer_type).count
  end

  def get_average_orders_per_customer(customer_type=nil)
    (get_orders_count(customer_type)/get_customers_count(customer_type)).round(2)
  end
  def get_average_order_items_per_customer(customer_type=nil)
    (get_items_sold_count(customer_type)/get_customers_count(customer_type)).round(2)
  end
end