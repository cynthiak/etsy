class AddAssociationsToCost < ActiveRecord::Migration
  def self.up
    add_column :costs, :product_id, :integer
    add_index 'costs', ['product_id'], :name => 'index_product_id4'

    add_column :costs, :variation_id, :integer
    add_index 'costs', ['variation_id'], :name => 'index_variation_id3'
  end

  def self.down
    remove_column :costs, :product_id
    remove_column :costs, :variation_id
  end
end
