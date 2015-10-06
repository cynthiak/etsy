class DropCostTable < ActiveRecord::Migration
  def up
    drop_table :costs
  end

  def down
    create_table :costs do |t|
      t.float :price
      t.float :cost

      t.timestamps null: false
    end
  end
end
