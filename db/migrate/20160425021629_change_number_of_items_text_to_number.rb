class ChangeNumberOfItemsTextToNumber < ActiveRecord::Migration
  def up
    change_column :orders, :number_of_items, :integer
    
  end

  def down
    change_column :orders, :number_of_items, :string
  end
end
