class Listing < ActiveRecord::Base
  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  belongs_to :product
  belongs_to :variation
  has_many :listings

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :etsy_listing_variation

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible :listing_type, :etsy_listing_variation, :product_id, :variation_id

  def get_order_items
    @order_items = OrderItem.where(etsy_listing_variation: self.etsy_listing_variation)
  end

end
