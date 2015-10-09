class AddColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :dimsum, :text
  end
end
