class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :listing_type
      t.text :etsy_listing_variation
    end
  end
end
