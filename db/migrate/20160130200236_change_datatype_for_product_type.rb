class ChangeDatatypeForProductType < ActiveRecord::Migration
  def self.up
    add_column :products, :product_type_id, :integer
    add_index 'products', ['product_type_id'], :name => 'index_product_type_id'
  end

  def self.down
    remove_column :products, :product_type_id
  end

end
