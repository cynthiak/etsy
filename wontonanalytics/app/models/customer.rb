class Customer < ActiveRecord::Base
  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  has_many :orders

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :etsy_username

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible :first_name, :last_name, :etsy_username, :email, :source, :ship_name, :ship_address1, :ship_address2, :ship_city, :ship_state, :ship_zipcode, :ship_country

  def get_first_purchase_date
    Order.where(customer: self).order(sale_date: :asc).first.sale_date
  end

  def get_last_purchase_date
    Order.where(customer: self).order(sale_date: :desc).first.sale_date
  end

  def get_orders
    orders = Order.where(customer: self)
  end

  def get_order_items
    OrderItem.joins(:order).where(orders: {customer: self})
  end

  def get_total_order_count
    get_orders.count
  end

  def get_total_order_items_count
    get_orders.sum(:number_of_items)
  end

  def get_total_spend
    # Does not subtract fees
    (get_orders.sum(:order_net) - get_orders.sum(:refund)).round(2)
  end

end
