class ProductsController < ApplicationController
  def index
  end

  def new
  end

  def import
    Product.import(params[:file])
    redirect_to products_url, notice: "Products imported."
  end

end
