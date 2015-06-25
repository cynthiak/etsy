class RemoveColumnsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :color
    remove_column :products, :size
  end

  def down
    add_column :products, :color, :text
    add_column :products, :size, :text
  end
end
