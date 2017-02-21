class ProductType < ActiveRecord::Base

  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  has_many :products
  has_many :expenses

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :product_type

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names

  # Products #################
  def get_products
    Product.where(product_type: self)
  end

  # Order Items #################
  def get_order_items(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    OrderItem.joins(:product, :order).where(products: {product_type_id: self.id}, orders: {sale_date: start_date..end_date})
  end

  def get_order_items_count(start_date=nil, end_date=nil)
    get_order_items(start_date, end_date).sum(:quantity)
  end
  def get_order_items_count_by_month(month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_order_items_count(start_date, end_date)
  end

  # Expenses #################
  def get_expenses
    Expense.where(product_type: self).sum(:amount).round(2)
  end

  # Revenue #################
  def get_revenue(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    OrderItem.joins(:product, :order).where(products: {product_type_id: self.id}, orders: {sale_date: start_date..end_date}).sum(:item_total).round(2)
  end
  def get_revenue_by_month(month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_revenue(start_date, end_date)
  end

  def get_average_revenue_per_item
    if self.get_revenue > 0
      (self.get_revenue / self.get_order_items_count).round(2)
    else
      0
    end
  end

  # Cost #################
  def get_cost_of_sold(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    order_items = get_order_items(start_date, end_date)
    total_cost = 0.0

    if order_items
      total_cost = order_items.sum(:cost)
    end
    return total_cost.round(2)
  end

  def get_average_cost_of_sold
    if get_order_items_count > 0
      return (get_cost_of_sold/get_order_items_count).round(2)
    else
      0
    end
  end

  # Profit #################
  def get_profit
    (self.get_revenue - self.get_expenses).round(2)
  end

  def get_average_profit
    if self.get_order_items_count > 0
      (self.get_profit / self.get_order_items_count).round(2)
    else
      0
    end
  end

  # Margin #################
  def get_margin(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    (self.get_revenue(start_date, end_date) - self.get_cost_of_sold(start_date, end_date)).round(2)
  end
  def get_margin_by_month(month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_margin(start_date, end_date)
  end

  def get_average_margin
    if self.get_order_items_count > 0
      (self.get_margin / self.get_order_items_count).round(2)
    else
      0
    end
  end

  # Unshipped #################
  def get_unshipped_items
    OrderItem.joins(:product).where(products: {product_type_id: self.id}).where(date_shipped: nil)
  end

  def get_unshipped_items_count
    get_unshipped_items.sum(:quantity)
  end


  # Helpers #################
  def get_first_sale_date
    Order.all.order("sale_date").first.sale_date
  end

  def get_last_sale_date
    Order.all.order("sale_date").last.sale_date
  end

end
