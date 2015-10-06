class ChangeListingsTextToString < ActiveRecord::Migration
  def up
    add_column :listings, :temp_etsy_listing_variation, :string

    Listing.find_each do |listing|
      temp_etsy_listing_variation = listing.etsy_listing_variation
      if listing.etsy_listing_variation.to_s.length > 255
        temp_etsy_listing_variation = listing.etsy_listing_variation[0,254]
      end
      listing.update_column(:temp_etsy_listing_variation, temp_etsy_listing_variation)
    end
    remove_column :listings, :etsy_listing_variation
    rename_column :listings, :temp_etsy_listing_variation, :etsy_listing_variation
  end

  def down
    change_column :listings, :etsy_listing_variation, :text
  end
end
