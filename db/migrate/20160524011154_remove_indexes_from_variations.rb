class RemoveIndexesFromVariations < ActiveRecord::Migration
  def self.up
    remove_index :variations, name: :index_product_id2
  end

  def self.down
    add_index 'variations', ['product_id'], :name => 'index_product_id2'
  end
end
