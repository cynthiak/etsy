class AddAssociationsToListing < ActiveRecord::Migration
  def self.up
    add_column :listings, :product_id, :integer
    add_index 'listings', ['product_id'], :name => 'index_product_id'

    add_column :listings, :variation_id, :integer
    add_index 'listings', ['variation_id'], :name => 'index_variation_id'
  end

  def self.down
    remove_column :listings, :product_id
    remove_column :listings, :variation_id
  end
end
