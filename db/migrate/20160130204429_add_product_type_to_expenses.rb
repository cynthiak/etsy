class AddProductTypeToExpenses < ActiveRecord::Migration
  def self.up
    add_column :expenses, :product_type_id, :integer
    add_index 'expenses', ['product_type_id'], :name => 'index_product_type_id_2'
  end

  def self.down
    remove_column :expenses, :product_type_id
  end
end
