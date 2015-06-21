class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|

      # From Etsy
      t.date :sale_date
      t.text :item_name
      t.text :buyer


      t.integer :quantity
      t.float :price

      t.text :coupon_code
      t.text :coupon_details
      t.float :coupon_discount

      t.float :order_shipping
      t.float :order_sales_tax

      t.float :item_total
      t.string :currency

      t.string :transaction_id
      t.string :listing_id

      t.date :date_paid
      t.date :date_shipped

      t.text :ship_name
      t.text :ship_address1
      t.text :ship_address2
      t.text :ship_city
      t.text :ship_state
      t.text :ship_zipcode
      t.text :ship_country

      t.string :order_id
      t.text :variations

      t.string :order_type
      t.string :listings_type
      t.string :payment_type

      t.text :inperson_discount
      t.text :inperson_location

      # Added by me
      t.float :etsy_fee
      t.text :notes

      # Added by default
      t.timestamps null: false
    end
  end
end
