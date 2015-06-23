class OrdersController < ApplicationController
  def index
    @orders = Order.all
    @orders_left_to_ship = Order.where(date_shipped: nil)
    @total_revenue = Order.all.sum(:order_net).to_i

    @average_revenue_per_order = @total_revenue / @orders.count

    @total_order_items = OrderItem.all.sum(:quantity)
    @average_items_per_order = @total_order_items.to_f / @orders.count
    @total_buyers = Order.select(:username).distinct.count
  end

  def new
  end

  def import
    Order.import(params[:file])
    redirect_to root_url, notice: "Orders imported."
  end
end
