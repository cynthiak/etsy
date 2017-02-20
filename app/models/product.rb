class Product < ActiveRecord::Base

  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  has_many :variations
  has_many :listings
  belongs_to :product_type

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :product_name

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      product = Product.find_by(product_name: row[0])
      product_params = {
          :product_name=> row[0],
          :dimsum=>row[1],
          :description=> row[2],
          :file=> row[3],
          :product_type=> row[4],
          :occasion=> row[5]
        }

      if (product)
        product.update(product_params)
      else
        product = Product.create(product_params)
      end
      product.save!
    end
  end

  # Listings ###############
  def get_listings
    Listing.where(product: self)
  end

  # Variations ###############
  def get_variations
    Variation.where(product:self).order(gender: :asc, style: :asc, color: :desc)
  end

  # Unshipped ###############
  def get_unshipped_order_items_count(order_type=nil)
    if order_type
      OrderItem.joins(:order).where(orders: {order_type: order_type}).where(product: self, date_shipped: nil).sum(:quantity)
    else
      OrderItem.where(product: self, date_shipped: nil).sum(:quantity)
    end
  end

  # Order Items ###############
  def get_order_items
    OrderItem.where(product: self)
  end

  def get_order_items_count
    OrderItem.where(product: self).sum(:quantity)
  end

  # Revenue ###############
  def get_total_revenue
    OrderItem.where(product:self).sum(:item_total).round(2)
  end

  def get_average_revenue
    (get_total_revenue/get_order_items_count).round(2)
  end

  # Cost ###############
  def get_total_cost_of_sold
    OrderItem.where(product: self).sum(:cost)
  end

  def get_average_cost
    (get_total_cost_of_sold/get_order_items_count).round(2)
  end

  # Margin ###############
  def get_margin_of_sold
    get_total_revenue - get_total_cost_of_sold
  end

  def get_margin_percentage_of_sold
    (get_margin_of_sold / get_total_revenue)*100
  end

  def get_average_margin
    (get_margin_of_sold/get_order_items_count).round(2)
  end



end
