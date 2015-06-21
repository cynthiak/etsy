class OrderItemsController < ApplicationController
  def index
  end

  def new
  end

  def import
    OrderItem.import(params[:file])
    redirect_to root_url, notice: "Order items imported."
  end
end
