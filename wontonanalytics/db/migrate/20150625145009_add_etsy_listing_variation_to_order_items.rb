class AddEtsyListingVariationToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :etsy_listing_variation, :text
  end
end
