class CreateVariations < ActiveRecord::Migration
  def change
    create_table :variations do |t|
      t.string :variation_name
      t.string :style
      t.string :gender
      t.string :color
      t.string :size
    end
  end
end
