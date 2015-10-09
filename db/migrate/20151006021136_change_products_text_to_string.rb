class ChangeProductsTextToString < ActiveRecord::Migration
  def up
    add_column :products, :temp_product_name, :string
    add_column :products, :temp_description, :string
    add_column :products, :temp_product_type, :string

    Product.find_each do |product|
      temp_product_name = product.product_name
      if product.product_name.to_s.length > 255
        temp_product_name = product.product_name[0,254]
      end
      product.update_column(:temp_product_name, temp_product_name)

      temp_description = product.description
      if product.description.to_s.length > 255
        temp_description = product.description[0,254]
      end
      product.update_column(:temp_description, temp_description)

      temp_product_type = product.product_type
      if product.product_type.to_s.length > 255
        temp_product_type = product.product_type[0,254]
      end
      product.update_column(:temp_product_type, temp_product_type)
    end

    remove_column :products, :product_name
    remove_column :products, :description
    remove_column :products, :product_type

    rename_column :products, :temp_product_name, :product_name
    rename_column :products, :temp_description, :description
    rename_column :products, :temp_product_type, :product_type
  end

  def down
    change_column :products, :product_name, :text
    change_column :products, :description, :text
    change_column :products, :product_type, :text
  end
end
