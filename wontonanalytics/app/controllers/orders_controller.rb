class OrdersController < ApplicationController
  def index
    @total_customers = Customer.count

    @orders = Order.all
    @completed_orders = Order.where.not(date_shipped: nil)
    @total_order_items_count = OrderItem.all.sum(:quantity)
    @orders_left_to_ship = Order.where(date_shipped: nil)

    @total_revenue = (Order.where(refund: nil).sum(:order_net) + Order.where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)

    @average_revenue_per_order = (@total_revenue.to_f / @orders.count).round(2)
    @average_revenue_per_order_item = (@total_revenue.to_f / @total_order_items_count).round(2)
    @average_items_per_order = (@total_order_items_count.to_f / @orders.count).round(2)
  end

  def new
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
