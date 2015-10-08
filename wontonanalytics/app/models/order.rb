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
    return self.sale_date.to_s + ' - ' + self.order_number.to_s + ' - ' + customer.display_name.to_s
  end

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      order = Order.find_by(order_number: row[1])

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
            :ship_country=> row[14]
          })
      end

      order_params = {
        :sale_date=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
        :order_number=> row[1],
        :username=> row[2],
        :full_name=> row[3],
        :first_name=> row[4],
        :last_name=> row[5],
        :number_of_items=> row[6],
        :payment_method=> row[7],
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
        :order_type=> row[29],
        :payment_type=> row[30],
        :inperson_discount=> row[31],
        :inperson_location=> row[32],
        :order_source=> "etsy",
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

      if row[11].to_f != 0
        payment_method = "card swiped"
      elsif row[12].to_f != 0
        payment_method = "card keyed"
      elsif row[13].to_f != 0
        payment_method = "cash"
      elsif row[14].to_f != 0
        payment_method = "wallet"
      elsif row[15].to_f != 0
        payment_method = "square gift card"
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
          :order_number=> row[21],
          :username=> square_username,
          :full_name=> "Square Customer",
          :first_name=> "Square",
          :last_name=> "Customer",
          :order_source=> "square",
          :customer_id=>customer.id,
          :date_shipped=> (DateTime.strptime row[0], "%m/%d/%y").strftime("%Y/%m/%d"),
          :shipping=> "0.0",
          :coupon_code=> row[4] == "$0.00" ? nil : row[4],
          :payment_method=> payment_method,
          :order_value=> row[3].delete('$').to_f,
          :sales_tax=> row[7].delete('$').to_f,
          :order_total=> row[5].delete('$').to_f,
          :card_processing_fees=> row[19].delete('$').to_f.abs,
          :order_net=> row[20].delete('$').to_f,
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