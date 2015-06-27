class OrdersController < ApplicationController
  def index
    @total_buyers = Order.select(:username).distinct.count

    @orders = Order.all
    @total_order_items = OrderItem.all.sum(:quantity)
    @orders_left_to_ship = Order.where(date_shipped: nil)

    @total_revenue = Order.all.sum(:order_net).to_f.round(2)
    @average_revenue_per_order = (@total_revenue.to_f / @orders.count).round(2)
    @average_revenue_per_order_item = (@total_revenue.to_f / @total_order_items).round(2)
    @average_items_per_order = (@total_order_items.to_f / @orders.count).round(2)
  end

  def new
  end

  def import
    Order.import(params[:file])
    redirect_to root_url, notice: "Orders imported."
  end
end
