class ProductsController < ApplicationController
  def index
    @order_items_count = OrderItem.all.sum(:quantity)
    @cards_sold_count = OrderItem.joins(:product).where(products: {product_type: "Card"}).sum(:quantity)
    @prints_sold_count = OrderItem.joins(:product).where(products: {product_type: "Print"}).sum(:quantity)
    @tshirts_sold_count = OrderItem.joins(:product).where(products: {product_type: "T-shirt"}).sum(:quantity)
    @stickers_sold_count = OrderItem.joins(:product).where(products: {product_type: "Stickers"}).sum(:quantity)

    @total_revenue = (Order.where(refund: nil).sum(:order_net) + Order.where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
    @cards_revenue = OrderItem.joins(:product).where(products: {product_type: "Card"}).sum(:item_total).round(2)
    @prints_revenue = OrderItem.joins(:product).where(products: {product_type: "Print"}).sum(:item_total).round(2)
    @tshirts_revenue = OrderItem.joins(:product).where(products: {product_type: "T-shirt"}).sum(:item_total).round(2)
    @stickers_revenue = OrderItem.joins(:product).where(products: {product_type: "Stickers"}).sum(:item_total).round(2)

    @average_revenue = (@total_revenue / @order_items_count).round(2)
    @average_cards_revenue = (@cards_revenue / @cards_sold_count).round(2)
    @average_prints_revenue = (@prints_revenue / @prints_sold_count).round(2)
    @average_tshirts_revenue = (@tshirts_revenue / @tshirts_sold_count).round(2)
    @average_stickers_revenue = (@stickers_revenue / @stickers_sold_count).round(2)

    @cards = Product.where(product_type: 'Card')
    @prints = Product.where(product_type: 'Print')
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
