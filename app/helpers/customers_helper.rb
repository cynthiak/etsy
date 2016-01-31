module CustomersHelper
  def get_customers
    Customer.all
  end
  def get_customers_count
    Customer.count
  end

  def get_average_orders_per_customer
    (get_orders_count/get_customers_count).round(2)
  end
  def get_average_order_items_per_customer
    (get_items_sold_count/get_customers_count).round(2)
  end

end