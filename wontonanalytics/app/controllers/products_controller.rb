class ProductsController < ApplicationController
  def index
    @cards = Product.where(product_type: 'Card')
    @tshirts = Product.where(product_type: 'T-shirt')
    @stickers = Product.where(product_type: 'Stickers')
  end

  def new
  end

  def import
    Product.import(params[:file])
    redirect_to products_url, notice: "Products imported."
  end

end
