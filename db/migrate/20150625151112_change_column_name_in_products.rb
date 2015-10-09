class ChangeColumnNameInProducts < ActiveRecord::Migration
  def up
    rename_column :products, :name, :product_name
  end

  def down
    rename_column :products, :product_name, :name
  end
end
