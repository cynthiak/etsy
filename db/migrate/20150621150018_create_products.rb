class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.text :file

      t.string :product_type

      t.text :occasion
      t.text :color
      t.text :size

      # Added by default
      t.timestamps null: false
    end
  end
end
