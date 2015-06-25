class OrderItem < ActiveRecord::Base

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      order_item = OrderItem.find_by(transaction_number: row[12])
      if (order_item)
        order_item.update({
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
            :etsy_listing_variation=> row[24].nil? ? row[13] : row[13] + "_" + row[24]
          })
      else
        order_item = OrderItem.create({
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
            :etsy_listing_variation=> row[24].nil? ? row[13] : row[13] + "_" + row[24]
          })
      end
      order_item.save!
    end
  end
end
