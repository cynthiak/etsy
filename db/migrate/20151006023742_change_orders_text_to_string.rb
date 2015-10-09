class ChangeOrdersTextToString < ActiveRecord::Migration
  def up
    add_column :orders, :temp_coupon_code, :string
    add_column :orders, :temp_coupon_details, :string
    add_column :orders, :temp_inperson_discount, :string
    add_column :orders, :temp_inperson_location, :string

    Order.find_each do |order|
      temp_coupon_code = order.coupon_code
      if order.coupon_code.to_s.length > 255
        temp_coupon_code = order.coupon_code[0,254]
      end
      order.update_column(:temp_coupon_code, temp_coupon_code)

      temp_coupon_details = order.coupon_details
      if order.coupon_details.to_s.length > 255
        temp_coupon_details = order.coupon_details[0,254]
      end
      order.update_column(:temp_coupon_details, temp_coupon_details)

      temp_inperson_discount = order.inperson_discount
      if order.inperson_discount.to_s.length > 255
        temp_inperson_discount = order.inperson_discount[0,254]
      end
      order.update_column(:temp_inperson_discount, temp_inperson_discount)

      temp_inperson_location = order.inperson_location
      if order.inperson_location.to_s.length > 255
        temp_inperson_location = order.inperson_location[0,254]
      end
      order.update_column(:temp_inperson_location, temp_inperson_location)
    end

    remove_column :orders, :coupon_code
    remove_column :orders, :coupon_details
    remove_column :orders, :inperson_discount
    remove_column :orders, :inperson_location

    rename_column :orders, :temp_coupon_code, :coupon_code
    rename_column :orders, :temp_coupon_details, :coupon_details
    rename_column :orders, :temp_inperson_discount, :inperson_discount
    rename_column :orders, :temp_inperson_location, :inperson_location
  end

  def down
    change_column :orders, :coupon_code, :text
    change_column :orders, :coupon_details, :text
    change_column :orders, :inperson_discount, :text
    change_column :orders, :inperson_location, :text
  end
end
