class Order < ActiveRecord::Base

  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  belongs_to :customer
  has_many :order_items

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :order_number

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names

  def display_name
    customer = Customer.find_by_id(self.customer_id)
    if customer
      return self.sale_date.to_s + ' - ' + self.order_number.to_s + ' - ' + customer.display_name.to_s
    else
      return self.sale_date.to_s + ' - ' + self.order_number.to_s
    end
  end

  def self.import_etsy(file)
    CSV.foreach(file.path, headers:true) do |row|
      order = Order.find_by(order_number: row[1])

      if row[1].include? "PO"
        customer_type = "Wholesale"
      else
        customer_type = "Retail"
      end

      customer = Customer.find_by(etsy_username: row[2])
      if !(customer)
        customer = Customer.create({
            :first_name=> row[4],
            :last_name=> row[5],
            :etsy_username=> row[2],
            :ship_name=> row[3],
            :ship_address1=> row[9],
            :ship_address2=> row[10],
            :ship_city=> row[11],
            :ship_state=> row[12],
            :ship_zipcode=> row[13],
            :ship_country=> row[14],
            :customer_type=> customer_type
          })
      end

      #set payment_type and payment_method
      payment_method = row[7]
      if row[30] == "cash"
        payment_type = "In Person"
        payment_method = "Cash"
      elsif row[30] == "online_cc"
        payment_type = "Online"
      elsif row[30] == "swipe"
        payment_type = "In Person"
      else
        payment_method = "Other"
        payment_type = "Other"
      end

      #set order_type
      order_number = row[1]
      if order_number.include? "PO"
        order_type = "Wholesale"
      else
        order_type = "Retail"
      end

      order_params = {
        #date_paid is marked by order item upload
        :sale_date=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
        :order_number=> row[1],
        :username=> row[2],
        :full_name=> row[3],
        :first_name=> row[4],
        :last_name=> row[5],
        :number_of_items=> row[6],
        :payment_method=> payment_method,
        :date_shipped=> row[8].nil? ? nil : DateTime.strptime(row[8], "%m/%d/%y").strftime("%Y/%m/%d"),
        :currency=> row[15],
        :order_value=> row[16],
        :coupon_code=> row[17],
        :coupon_details=> row[18],
        :shipping=> row[19],
        :sales_tax=> row[20],
        :order_total=> row[21],
        :card_processing_fees=> row[23],
        :order_net=> row[24],
        :adjusted_order_total=> row[25],
        :adjusted_card_processing_fees=> row[26],
        :adjusted_net_order_amount=> row[27],
        :order_type=> order_type,
        :payment_type=> payment_type,
        :inperson_discount=> row[31],
        :inperson_location=> row[32],
        :order_source=> "Etsy",
        :customer_id=>customer.id,
        :refund=> row[25].nil? ? nil : (row[21].to_f - row[25].to_f).round(2)
      }

      if (order)
        order.update(order_params)
      else
        order = Order.create(order_params)
      end

      order.save!
    end
  end

  def self.import_square(file)
    CSV.foreach(file.path, headers:true) do |row|
      order = Order.find_by(order_number: row[21])

      square_username = "sq_" + row[21]
      customer = Customer.find_by(etsy_username: square_username)
      if !(customer)
        customer = Customer.create({
            :etsy_username=> square_username,
            :first_name=> "Square",
            :last_name=> "Customer"
          })
      end

      if row[11].delete('$').to_f != 0
        payment_method = "Credit Card"
      elsif row[12].delete('$').to_f != 0
        payment_method = "Credit Card"
      elsif row[13].delete('$').to_f != 0
        payment_method = "Cash"
      elsif row[14].delete('$').to_f != 0
        payment_method = "Wallet"
      elsif row[15].delete('$').to_f != 0
        payment_method = "Square Gift Card"
      end

      if row[30] == "Refund"
        refund = row[10].delete('$').to_f
        if order
          order_params = {
            :adjusted_order_total=> order.order_total + refund,
            :adjusted_net_order_amount=> order.order_net + refund,
            :refund=> refund.abs
          }
        end
      else
        order_params = {
          :sale_date=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
          :date_paid=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
          :order_number=> row[21],
          :username=> square_username,
          :full_name=> "Square Customer",
          :first_name=> "Square",
          :last_name=> "Customer",
          :payment_method=> payment_method,
          :order_value=> row[3].delete('$').to_f,
          :shipping=> "0.0",
          :sales_tax=> row[7].delete('$').to_f,
          :order_total=> row[5].delete('$').to_f,
          :card_processing_fees=> row[19].delete('$').to_f.abs,
          :order_net=> row[20].delete('$').to_f,
          :order_type=>"Retail",
          :payment_type=>"In Person",
          :order_source=> "Square",
          :customer_id=>customer.id,
          :date_shipped=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
          :coupon_code=> row[4] == "$0.00" ? nil : row[4],
          :inperson_discount=> row[4].delete('$').to_f
        }
      end

      if (order)
        order.update(order_params)
      else
        order = Order.create(order_params)
      end

      order.save!
    end
  end



  def get_order_items
    OrderItem.where(order: self)
  end




end