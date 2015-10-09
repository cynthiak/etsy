module CustomersHelper
  def get_customers
    Customer.all
  end
  def get_customers_count
    Customer.count
  end
end