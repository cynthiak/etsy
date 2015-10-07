class OrdersController < ApplicationController
  def index
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
