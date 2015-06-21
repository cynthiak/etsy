class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      # From Etsy
      t.date :sale_date
      t.string :order_id

      t.string :buyer_user_id
      t.string :full_name
      t.string :first_name
      t.string :last_name

      t.string :number_of_items

      t.string :payment_method

      t.date :date_shipped
      t.text :ship_address1
      t.text :ship_address2
      t.text :ship_city
      t.text :ship_state
      t.text :ship_zipcode
      t.text :ship_country

      t.string :currency
      t.float :order_value

      t.text :coupon_code
      t.text :coupon_details

      t.float :shipping

      t.float :sales_tax
      t.float :order_total
      t.text :status
      t.float :card_processing_fees
      t.float :order_net

      t.float :adjusted_order_total
      t.float :adjusted_card_processing_fees
      t.float :adjusted_net_order_amount

      t.text :buyer

      t.string :order_type
      t.string :payment_type

      t.text :inperson_discount
      t.text :inperson_location

      # Added by me
      t.string :order_source
      t.float :packaging_cost
      t.float :shipping_cost
      t.text :notes

      # Added by default
      t.timestamps null: false
    end
  end
end
