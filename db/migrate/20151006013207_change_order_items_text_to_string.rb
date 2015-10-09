class ChangeOrderItemsTextToString < ActiveRecord::Migration
  def up
    add_column :order_items, :temp_item_name, :string
    add_column :order_items, :temp_coupon_code, :string
    add_column :order_items, :temp_coupon_details, :string
    add_column :order_items, :temp_variations, :string
    add_column :order_items, :temp_etsy_listing_variation, :string

    OrderItem.find_each do |order_item|
      temp_item_name = order_item.item_name
      if order_item.item_name.to_s.length > 255
        temp_item_name = order_item.item_name[0,254]
      end
      order_item.update_column(:temp_item_name, temp_item_name)

      temp_item_name = order_item.item_name
      if order_item.item_name.to_s.length > 255
        temp_item_name = order_item.item_name[0,254]
      end
      order_item.update_column(:temp_item_name, temp_item_name)

      temp_item_name = order_item.item_name
      if order_item.item_name.to_s.length > 255
        temp_item_name = order_item.item_name[0,254]
      end
      order_item.update_column(:temp_item_name, temp_item_name)

      temp_item_name = order_item.item_name
      if order_item.item_name.to_s.length > 255
        temp_item_name = order_item.item_name[0,254]
      end
      order_item.update_column(:temp_item_name, temp_item_name)

      temp_item_name = order_item.item_name
      if order_item.item_name.to_s.length > 255
        temp_item_name = order_item.item_name[0,254]
      end
      order_item.update_column(:temp_item_name, temp_item_name)
    end

    remove_column :order_items, :item_name
    remove_column :order_items, :coupon_code
    remove_column :order_items, :coupon_details
    remove_column :order_items, :variations
    remove_column :order_items, :etsy_listing_variation

    rename_column :order_items, :temp_item_name, :item_name
    rename_column :order_items, :temp_coupon_code, :coupon_code
    rename_column :order_items, :temp_coupon_details, :coupon_details
    rename_column :order_items, :temp_variations, :variations
    rename_column :order_items, :temp_etsy_listing_variation, :etsy_listing_variation
  end

  def down
    change_column :order_items, :item_name, :text
    change_column :order_items, :coupon_code, :text
    change_column :order_items, :coupon_details, :text
    change_column :order_items, :variations, :text
    change_column :order_items, :etsy_listing_variation, :text
  end
end
