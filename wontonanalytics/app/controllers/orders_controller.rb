class OrdersController < ApplicationController
  def index
  end

  def new
    @order = Order.new({
      sale_date: Date.today,
      date_shipped: Date.today,
      currency: "USD",
      shipping: "0",
      sales_tax: "0",
      payment_method: "cash"
    })
    @customers = Customer.all.order(:first_name)
  end

  def create
    order_params = params[:order]
    order_params[:order_net] = params[:order][:order_total]
    @order = Order.new(order_params)

    if @order.save
      redirect_to new_order_item_path, alert: "Order created successfully. Add your order items."
    else
      redirect_to new_order_path, alert: "Error creating order."
    end
  end

  def import
    Order.import(params[:file])
    redirect_to orders_url, notice: "Orders imported."
  end

  def import_square
    Order.import_square(params[:file])
    redirect_to orders_url, notice: "Orders imported."
  end

end
