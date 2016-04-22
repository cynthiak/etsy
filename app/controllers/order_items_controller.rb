class OrderItemsController < ApplicationController
  def index
  end

  def new
    @last_order = Order.order("created_at").last
    @order_item = OrderItem.new({
      order_id: @last_order.id,
      date_shipped: nil
    })
    @orders = Order.all.order(:sale_date)
    @products = Product.all.order(:product_name)
    @variations = Variation.all.order(:product_id)
  end

  def create
    order_item_params = params[:order_item]
    @order_item = OrderItem.new(order_item_params)

    if @order_item.save
      redirect_to new_order_item_path, alert: "Order item created successfully. Add another order item."
    else
      redirect_to new_order_item_path, alert: "Error creating order item."
    end
  end

  def import
    OrderItem.import(params[:file])
    redirect_to order_items_url, notice: "Order items imported."
  end

  def import_square
    OrderItem.import_square(params[:file])
    redirect_to order_items_url, notice: "Order items imported."
  end
end
