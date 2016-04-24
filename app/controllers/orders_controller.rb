class OrdersController < ApplicationController
  def index
  end

  def wholesale
  end

  def new
    @order_types = Order.order(:order_type).uniq.pluck(:order_type)
    @payment_types = Order.order(:payment_type).uniq.pluck(:payment_type)
    @payment_methods = Order.order(:payment_method).uniq.pluck(:payment_method)
    @order_sources = Order.order(:order_source).uniq.pluck(:order_source)

    @order = Order.new({
      sale_date: Date.today,
      date_shipped: nil,
      currency: "USD",
      shipping: "0",
      sales_tax: "0",
      payment_method: "Cash"
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
