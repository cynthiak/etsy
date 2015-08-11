class OrderItem < ActiveRecord::Base

  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  belongs_to :order
  belongs_to :listing
  belongs_to :product
  belongs_to :variation

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :item_name

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      order_item = OrderItem.find_by(transaction_number: row[12])

      # Find order
      order = Order.find_by(order_number: row[23])

      # Find listing
      etsy_listing_variation = row[24].nil? ? row[13] : row[13] + "_" + row[24]
      listing = Listing.find_by(etsy_listing_variation: etsy_listing_variation)
      product_id = nil
      variation_id = nil
      if !(listing)
        listing = Listing.create({
            :listing_type=> "etsy",
            :etsy_listing_variation=>etsy_listing_variation
          })
      else
        product_id = listing.product.id
        if (listing.variation)
          variation_id = listing.variation.id
        end
      end

      # Set row parameters
      order_item_params = {
        :sale_date=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
        :item_name=> row[1],
        :buyer=> row[2],
        :quantity=> row[3],
        :price=> row[4],
        :coupon_code=> row[5],
        :coupon_details=> row[6],
        :coupon_discount=> row[7],
        :order_shipping=> row[8],
        :order_sales_tax=> row[9],
        :item_total=> row[10],
        :currency=> row[11],
        :transaction_number=> row[12],
        :listing_number=> row[13],
        :date_paid=> row[14].nil? ? nil : (DateTime.strptime row[14], "%m/%d/%Y").strftime("%Y/%m/%d"),
        :date_shipped => row[15].nil? ? nil : (DateTime.strptime row[15], "%m/%d/%Y").strftime("%Y/%m/%d"),
        :ship_name=> row[16],
        :ship_address1=> row[17],
        :ship_address2=> row[18],
        :ship_city=> row[19],
        :ship_state=> row[20],
        :ship_zipcode=> row[21],
        :ship_country=> row[22],
        :order_number=> row[23],
        :variations=> row[24],
        :order_type=> row[25],
        :listings_type=> row[26],
        :payment_type=> row[27],
        :inperson_discount=> row[28],
        :inperson_location=> row[29],
        :etsy_listing_variation=> etsy_listing_variation,
        :order_id => order.id,
        :listing_id => listing.id,
        :product_id => product_id,
        :variation_id => variation_id
      }

      if (order_item)
        order_item.update(order_item_params)
      else
        order_item = OrderItem.create(order_item_params)
      end

      order_item.save!
    end
  end

  def self.import_square(file)
    CSV.foreach(file.path, headers:true) do |row|
      # Establish parameters
      if row[6] != "Regular Price"
        variation_name = row[6]
        transaction_number = row[13] + "_" + row[4] + "_" + variation_name
        listing_variation = row[4] + variation_name
      else
        transaction_number = row[13] + "_" + row[4]
        listing_variation = row[4]
      end

      # Find order item
      order_item = OrderItem.find_by(transaction_number: transaction_number)

      # Find order
      order = Order.find_by(order_number: row[13])

      # Find listing
      listing = Listing.find_by(etsy_listing_variation: listing_variation)
      product_id = nil
      variation_id = nil
      if !(listing)
        listing = Listing.create({
            :listing_type=> "square",
            :etsy_listing_variation=>listing_variation
          })
      else
        product_id = listing.product.id
        if (listing.variation)
          variation_id = listing.variation.id
        end
      end

      # Set row parameters
      order_item_params = {
        :sale_date=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
        :item_name=> row[4],
        :quantity=> row[5],
        :coupon_discount=> row[10].delete('$').to_f.abs,
        :order_shipping=> "0.0",
        :order_sales_tax=> row[12].delete('$').to_f,
        :item_total=> row[9].delete('$').to_f,
        :date_paid=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
        :date_shipped => (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
        :transaction_number => transaction_number,
        :order_number=> row[13],
        :variations=> row[6],
        :etsy_listing_variation=> listing_variation,
        :order_id => order.id,
        :listing_id => listing.id,
        :product_id => product_id,
        :variation_id => variation_id
      }

      if (order_item)
        order_item.update(order_item_params)
      else
        order_item = OrderItem.create(order_item_params)
      end

      order_item.save!











      # order_item = OrderItem.find_by(order_number: row[21])

      # square_username = "sq_" + row[21]
      # customer = Customer.find_by(etsy_username: square_username)
      # if !(customer)
      #   customer = Customer.create({
      #       :etsy_username=> square_username,
      #       :first_name=> "Square",
      #       :last_name=> "Customer"
      #     })
      # end

      # if row[11].to_f > 0
      #   payment_method = "card swiped"
      # elsif row[12].to_f > 0
      #   payment_method = "card keyed"
      # elsif row[13].to_f > 0
      #   payment_method = "cash"
      # elsif row[14].to_f > 0
      #   payment_method = "wallet"
      # elsif row[15].to_f > 0
      #   payment_method = "square gift card"
      # end

      # order_params = {
      #   :sale_date=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
      #   :order_number=> row[21],
      #   :username=> square_username,
      #   :full_name=> "Square Customer",
      #   :first_name=> "Square",
      #   :last_name=> "Customer",
      #   :order_source=> "square",
      #   :customer_id=>customer.id,
      #   :date_shipped=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
      #   :shipping=> "0.0",
      #   :payment_method=> payment_method,
      #   :order_value=> row[3].delete('$').to_f,
      #   :sales_tax=> row[7].delete('$').to_f,
      #   :order_total=> row[5].delete('$').to_f,
      #   :card_processing_fees=> row[19].delete('$').to_f.abs,
      #   :order_net=> row[20].delete('$').to_f,
      #   :inperson_discount=> row[4].delete('$').to_f
      # }

      # if (order)
      #   order.update(order_params)
      # else
      #   order = Order.create(order_params)
      # end

      # order.save!
    end
  end

end
