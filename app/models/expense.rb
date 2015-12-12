class Expense < ActiveRecord::Base

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names

  def self.import(file)
  	#date
  	date = nil

    #hash
    etsy_fee_counts = Hash.new
    etsy_fee_amount = Hash.new

    CSV.foreach(file.path, headers:true) do |row|
      if date == nil
        date = DateTime.strptime(row[0], "%m/%d/%Y").strftime("%Y/%m/%d")
      end

      activity = row[3]
      payment = row[4].to_f
      fee = row[5].to_f

      if !etsy_fee_counts.has_key?(activity)
        etsy_fee_counts[activity] = 0
        etsy_fee_amount[activity] = 0.0
      end

      etsy_fee_counts[activity] = etsy_fee_counts[activity] + 1

      if (payment > 0 && activity.include?("credit"))
        original_activity = activity.slice!(" credit")
        if !etsy_fee_counts.has_key?(original_activity)
          etsy_fee_amount[original_activity] = 0 - payment
        else
          etsy_fee_amount[original_activity] = etsy_fee_amount[original_activity] - payment
        end
        etsy_fee_amount[activity] = etsy_fee_amount[activity].to_f - payment
      elsif (fee > 0)
        etsy_fee_amount[activity] = etsy_fee_amount[activity] + fee
      end

    end

    ################### CREATE THE EXPENSE
    etsy_fee_counts.each do |type, count|
      if etsy_fee_amount[type] > 0
        if type == "Promoted Listings"
          Expense.create({
            :date => date,
            :name => "(Fees) " + count.to_s + " " + type,
            :expense_type => "Advertising",
            :vendor => "Etsy",
            :amount => etsy_fee_amount[type].round(2)
            })
        else
          Expense.create({
            :date => date,
            :name => "(Fees) " + count.to_s + " " + type,
            :expense_type => "Etsy Fees",
            :vendor => "Etsy",
            :amount => etsy_fee_amount[type].round(2)
            })
        end
      end
    end
  end




end
