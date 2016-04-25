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


  def get_products
    Product.where(product_type: self)
  end

  def get_order_items
    OrderItem.joins(:product).where(products: {product_type_id: self.id})
  end

  def get_order_items_count
    get_order_items.sum(:quantity)
  end

  def get_expenses
    Expense.where(product_type: self).sum(:amount).round(2)
  end

  def get_revenue
    OrderItem.joins(:product).where(products: {product_type_id: self.id}).sum(:item_total).round(2)
  end

  def get_average_revenue_per_item
    if self.get_revenue > 0
      (self.get_revenue / self.get_order_items_count).round(2)
    else
      0
    end
  end

  def get_cost_of_sold
    order_items = get_order_items
    total_cost = 0.0

    if order_items
      order_items.each do |order_item|
        if order_item.product.cost
          total_cost = total_cost + order_item.product.cost
        end
      end
      return total_cost.round(2)
    else
      0
    end
  end

  def get_average_cost_of_sold
    if get_order_items_count > 0
      return (get_cost_of_sold/get_order_items_count).round(2)
    else
      0
    end
  end

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

  def get_margin
    (self.get_revenue - self.get_cost_of_sold).round(2)
  end

  def get_average_margin
    if self.get_order_items_count > 0
      (self.get_margin / self.get_order_items_count).round(2)
    else
      0
    end
  end

  def get_unshipped_items
    OrderItem.joins(:product).where(products: {product_type_id: self.id}).where(date_shipped: nil)
  end

  def get_unshipped_items_count
    get_unshipped_items.sum(:quantity)
  end


end
