class OrderItemsController < ApplicationController
  def index
  	@items_to_ship = OrderItem.where(date_shipped: nil)
    @cards_to_ship = OrderItem.joins(:product).where(products: {product_type: "Card"}).where(date_shipped: nil)
    @prints_to_ship = OrderItem.joins(:product).where(products: {product_type: "Print"}).where(date_shipped: nil)
  	@tshirts_to_ship = OrderItem.joins(:product).where(products: {product_type: "T-shirt"}).where(date_shipped: nil)
    @tshirts_shipped = OrderItem.joins(:product).where(products: {product_type: "T-shirt"}).where.not(date_shipped: nil)
  	@stickers_to_ship = OrderItem.joins(:product).where(products: {product_type: "Stickers"}).where(date_shipped: nil)

  	@total_items_to_ship = @items_to_ship.sum(:quantity)
  	@total_cards_to_ship = @cards_to_ship.sum(:quantity)
    @total_prints_to_ship = @prints_to_ship.sum(:quantity)
  	@total_tshirts_to_ship = @tshirts_to_ship.sum(:quantity)
  	@total_stickers_to_ship = @stickers_to_ship.sum(:quantity)

  	@cards = Product.where(product_type: "Card")
    @prints = Product.where(product_type: "Print")
  	@tshirts = Product.where(product_type: "T-shirt")
  	@stickers = Product.where(product_type: "Stickers")


  end

  def new
  end

  def import
    OrderItem.import(params[:file])
    redirect_to order_items_url, notice: "Order items imported."
  end
end
