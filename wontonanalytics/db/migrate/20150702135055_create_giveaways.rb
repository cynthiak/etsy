class CreateGiveaways < ActiveRecord::Migration
  def change
    create_table :giveaways do |t|
      t.date :date_ordered
      t.date :date_shipped
      t.string :giveaway_type
      t.string :campaign
      t.integer :quantity
      t.float :shipping_cost
      t.string :shipping_method

      t.timestamps null: false
    end
  end
end
