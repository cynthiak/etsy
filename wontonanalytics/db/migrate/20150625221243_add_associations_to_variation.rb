class AddAssociationsToVariation < ActiveRecord::Migration
  def self.up
    add_column :variations, :product_id, :integer
    add_index 'variations', ['product_id'], :name => 'index_product_id2'
  end

  def self.down
    remove_column :variations, :product_id
  end
end
