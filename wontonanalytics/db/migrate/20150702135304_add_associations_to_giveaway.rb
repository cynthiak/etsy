class AddAssociationsToGiveaway < ActiveRecord::Migration
  def self.up
    add_column :giveaways, :product_id, :integer
    add_index 'giveaways', ['product_id'], :name => 'index_product_id5'

    add_column :giveaways, :variation_id, :integer
    add_index 'giveaways', ['variation_id'], :name => 'index_variation_id4'

    add_column :giveaways, :customer_id, :integer
    add_index 'giveaways', ['customer_id'], :name => 'index_customer_id2'
  end

  def self.down
    remove_column :giveaways, :product_id
    remove_column :giveaways, :variation_id
    remove_column :giveaways, :customer_id
  end
end
