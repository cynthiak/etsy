class ProductsController < ApplicationController
  def index
    @products = Product.order(:product_name)
    @cards = Product.where(product_type: 'card')
  end

  def new
  end

  def import
    Product.import(params[:file])
    redirect_to products_url, notice: "Products imported."
  end

end
