class AddProductTypeToVariations < ActiveRecord::Migration
  def self.up
    add_column :variations, :product_type_id, :integer
    add_index 'variations', ['product_type_id'], :name => 'product_type_id_3'
  end

  def self.down
    remove_column :variations, :product_type_id
  end
end
