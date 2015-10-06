class DropColumnsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :file
    remove_column :products, :occasion
    remove_column :products, :dimsum
  end

  def down
    add_column :products, :file, :text
    add_column :products, :occasion, :text
    add_column :products, :dimsum, :text
  end
end
