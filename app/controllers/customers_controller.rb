class CustomersController < ApplicationController

  def index
    @total_customers = Customer.count
    @customers = Customer.all
  end

  def show
    @customer = Customer.find_by_id(params[:id])
    @orders = Order.where(customer: @customer)
  end

end
