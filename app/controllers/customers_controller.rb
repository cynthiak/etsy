class CustomersController < ApplicationController

  def index
    @total_customers = Customer.count
    @customers = Customer.all
  end

end
