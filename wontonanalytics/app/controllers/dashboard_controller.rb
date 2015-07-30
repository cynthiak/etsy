class DashboardController < ApplicationController

  def index
    # To ship
    @orders_left_to_ship = Order.where(date_shipped: nil)
    @total_items_to_ship = OrderItem.where(date_shipped: nil).sum(:quantity)
    @total_cards_to_ship = OrderItem.joins(:product).where(products: {product_type: "Card"}).where(date_shipped: nil).sum(:quantity)
    @total_prints_to_ship = OrderItem.joins(:product).where(products: {product_type: "Print"}).where(date_shipped: nil).sum(:quantity)
    @total_tshirts_to_ship = OrderItem.joins(:product).where(products: {product_type: "T-shirt"}).where(date_shipped: nil).sum(:quantity)
    @total_stickers_to_ship = OrderItem.joins(:product).where(products: {product_type: "Stickers"}).where(date_shipped: nil).sum(:quantity)
    @total_laptopstickers_to_ship = OrderItem.joins(:product).where(products: {product_type: "Laptop Sticker"}).where(date_shipped: nil).sum(:quantity)


    # Customers and Orders
    @total_customers = Customer.count

    @orders = Order.all
    @completed_orders = Order.where.not(date_shipped: nil)
    @total_order_items_count = OrderItem.all.sum(:quantity)
    

    # Revenue
    @total_revenue = (Order.where(refund: nil).sum(:order_net) + Order.where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)

    @average_revenue_per_order = (@total_revenue.to_f / @orders.count).round(2)
    @average_revenue_per_order_item = (@total_revenue.to_f / @total_order_items_count).round(2)
    @average_items_per_order = (@total_order_items_count.to_f / @orders.count).round(2)


    # Expenses
    @total_expenses = Expense.all.sum(:amount).round(2)
    @total_etsy_fees = Expense.where(expense_type: "Etsy Fees").sum(:amount).round(2)
    @total_advertising = Expense.where(expense_type: "Advertising").sum(:amount).round(2)
    @total_supplies = Expense.where(expense_type: "Supplies").sum(:amount).round(2)
    @total_fees = Expense.where(expense_type: "Fees").sum(:amount).round(2)
    @total_marketing = Expense.where(expense_type: "Marketing").sum(:amount).round(2)
    @total_shipping = Expense.where(expense_type: "Shipping").sum(:amount).round(2)


    # Profit
    @profit = (@total_revenue - @total_expenses).round(2)

    # For finding average cost of items and number of items needed to be sold in order to reach 0, and for products section
    @order_items_count = OrderItem.all.sum(:quantity)
    @cards_sold_count = OrderItem.joins(:product).where(products: {product_type: "Card"}).sum(:quantity)
    @prints_sold_count = OrderItem.joins(:product).where(products: {product_type: "Print"}).sum(:quantity)
    @tshirts_sold_count = OrderItem.joins(:product).where(products: {product_type: "T-shirt"}).sum(:quantity)
    @stickers_sold_count = OrderItem.joins(:product).where(products: {product_type: "Stickers"}).sum(:quantity)
    @laptopstickers_sold_count = OrderItem.joins(:product).where(products: {product_type: "Laptop Sticker"}).sum(:quantity)

    @total_revenue = (Order.where(refund: nil).sum(:order_net) + Order.where.not(refund:nil).sum(:adjusted_net_order_amount)).round(2)
    @cards_revenue = OrderItem.joins(:product).where(products: {product_type: "Card"}).sum(:item_total).round(2)
    @prints_revenue = OrderItem.joins(:product).where(products: {product_type: "Print"}).sum(:item_total).round(2)
    @tshirts_revenue = OrderItem.joins(:product).where(products: {product_type: "T-shirt"}).sum(:item_total).round(2)
    @stickers_revenue = OrderItem.joins(:product).where(products: {product_type: "Stickers"}).sum(:item_total).round(2)
    @laptopstickers_revenue = OrderItem.joins(:product).where(products: {product_type: "Laptop Sticker"}).sum(:item_total).round(2)

    @average_revenue = (@total_revenue / @order_items_count).round(2)
    @average_cards_revenue = (@cards_revenue / @cards_sold_count).round(2)
    @average_prints_revenue = (@prints_revenue / @prints_sold_count).round(2)
    @average_tshirts_revenue = (@tshirts_revenue / @tshirts_sold_count).round(2)
    @average_stickers_revenue = (@stickers_revenue / @stickers_sold_count).round(2)
    @average_laptopstickers_revenue = (@laptopstickers_revenue / @laptopstickers_sold_count).round(2)

    @cards_to_sell = (@profit / @average_cards_revenue).abs.ceil
    @prints_to_sell = (@profit / @average_prints_revenue).abs.ceil
    @tshirts_to_sell = (@profit / @average_tshirts_revenue).abs.ceil
    @stickers_to_sell = (@profit / @average_stickers_revenue).abs.ceil
    @laptopstickers_to_sell = (@profit / @average_laptopstickers_revenue).abs.ceil


  end

end
