class Variation < ActiveRecord::Base
  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  has_many :products
  has_many :listings
  belongs_to :product_type

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :variation_name

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible :style, :gender, :color, :size, :quantity, :device, :product_type_id

  def display_name
    display_name = []
    if self.product_type != ""
      display_name.push(self.product_type.product_type)
    end
    if self.style != ""
      display_name.push(self.style)
    end
    if self.gender != ""
      display_name.push(self.gender)
    end
    if self.color != ""
      display_name.push(self.color)
    end
    if self.size != ""
      display_name.push(self.size)
    end
    if self.quantity != nil
      display_name.push(self.quantity.to_s)
    end
    if self.device != ""
      display_name.push(self.device)
    end

    display = ""
    display_name.each_with_index do |item, index|
      if index != display_name.size - 1
        display += item + " - "
      else
        display += item
      end
    end
    return display
  end

  def get_unshipped_order_items_count
    OrderItem.where(variation: self).where(date_shipped: nil).sum(:quantity)
  end

  def get_shipped_order_items_count
    OrderItem.where(variation: self).where.not(date_shipped: nil).sum(:quantity)
  end

  def get_sold_order_items_count
    OrderItem.where(variation: self).sum(:quantity)
  end

end
