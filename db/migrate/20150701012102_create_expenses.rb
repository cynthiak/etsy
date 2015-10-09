class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date :date
      t.string :name
      t.text :description
      t.string :type
      t.string :vendor
      t.float :amount
      
      t.timestamps null: false
    end
  end
end
