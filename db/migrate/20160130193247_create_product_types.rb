class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :product_type
    end
  end
end
