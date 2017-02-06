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

  def display_name
    order = Order.find_by_id(self.order_id)
    product = Product.find_by_id(self.product_id)
    if product
      return order.display_name.to_s + ' - ' + product.product_name
    else
      return order.display_name.to_s + ' - '
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      order_item = OrderItem.find_by(transaction_number: row[12])

      # PO's matching with Order ID's
      pos = {
        "1093444835" => "PO#30116814",
        "1095994338" => "PO#29904143",
        "1101168959" => "PO#32472318"
      }

      # Find order
      order = Order.find_by(order_number: row[23])
      if !(order)
        order = Order.find_by(order_number: pos[row[23]])
      end
      if order
        order_id = order.id
        order.update(:date_paid=> row[14].nil? ? nil : (DateTime.strptime(row[14], "%m/%d/%Y")).strftime("%Y/%m/%d"))
      else
        order_id = nil
      end

      # Find listing
      etsy_listing_variation = row[24].nil? ? row[13] : row[13] + "_" + row[24]
      listing = Listing.find_by(etsy_listing_variation: etsy_listing_variation)
      product_id = nil
      variation_id = nil
      if !(listing)
        listing = Listing.create({
            :listing_type=> "etsy",
            :etsy_listing_variation=>etsy_listing_variation,
            :item_name=>item_name
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
        :quantity=> row[3],
        :price=> row[4],
        :coupon_code=> row[5],
        :coupon_details=> row[6],
        :coupon_discount=> row[7],
        :item_total=> row[10],
        :currency=> row[11],
        :transaction_number=> row[12],
        :listing_number=> row[13],
        :date_shipped => row[15].nil? ? nil : (DateTime.strptime row[15], "%m/%d/%Y").strftime("%Y/%m/%d"),
        :order_number=> row[23],
        :variations=> row[24],
        :order_type=> row[25],
        :etsy_listing_variation=> etsy_listing_variation,
        :order_id => order_id,
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
        :item_total=> row[9].delete('$').to_f,
        :date_paid=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
        :date_shipped => (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
        :transaction_number => transaction_number,
        :order_number=> row[13],
        :variations=> variation_name,
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
    end
  end

end
