class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :firstname
      t.text :lastname
      t.text :etsy_username
      t.text :email
      t.text :source
      t.text :ship_name
      t.text :ship_address1
      t.text :ship_address2
      t.text :ship_city
      t.text :ship_state
      t.text :ship_zipcode
      t.text :ship_country

      t.timestamps null: false
    end
  end
end
