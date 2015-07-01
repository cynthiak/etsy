class Expense < ActiveRecord::Base

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names

  def self.import(file)
  	#date
  	date = nil

  	# transactions
  	transactions_count = 0
  	transactions_amount = 0.0

    # auto-renew sold
    autorenews_count = 0
  	autorenews_amount = 0.0

    # listing
    listings_count = 0
    listings_amount = 0.0

    # multi-quantity
    multiquantity_count = 0
    multiquantity_amount = 0.0

    # promoted listings
    promotedlistings_count = 0
    promotedlistings_amount = 0.0

    # private listing
    privatelisting_count = 0
    privatelisting_amount = 0.0


    CSV.foreach(file.path, headers:true) do |row|
      if date == nil
      	date = DateTime.strptime(row[0], "%m/%d/%Y").strftime("%Y/%m/%d")
      end

      if row[3] == "transaction"
      	transactions_count = transactions_count + 1
      	transactions_amount = transactions_amount + row[5].to_f
      elsif row[3] == "auto-renew sold "
      	autorenews_count = autorenews_count + 1
      	autorenews_amount = autorenews_amount + row[5].to_f
      elsif row[3] == "listing"
      	listings_count = listings_count + 1
      	listings_amount = listings_amount + row[5].to_f
      elsif row[3] == "multi-quantity"
      	multiquantity_count = multiquantity_count + 1
      	multiquantity_amount = multiquantity_amount + row[5].to_f
      elsif row[3] == "Promoted Listings"
      	promotedlistings_count = promotedlistings_count + 1
      	promotedlistings_amount = promotedlistings_amount + row[5].to_f
      elsif row[3] == "private listing"
      	privatelisting_count = privatelisting_count + 1
      	privatelisting_amount = privatelisting_amount + row[5].to_f
      end

    end

    if transactions_count > 0
	  Expense.create({
	    :date => date,
	    :name => "Transaction Fees",
	    :description => transactions_count.to_s + " transactions",
	    :expense_type => "Etsy Fees",
	    :vendor => "Etsy",
	    :amount => transactions_amount.round(2)
	    })
	end

	if autorenews_count > 0
	  Expense.create({
	    :date => date,
	    :name => "Auto-Renewal Listing Fees",
	    :description => autorenews_count.to_s + " auto-renewals",
	    :expense_type => "Etsy Fees",
	    :vendor => "Etsy",
	    :amount => autorenews_amount.round(2)
	    })
	end

    if listings_count > 0
	  Expense.create({
	    :date => date,
	    :name => "Listing Fees",
	    :description => listings_count.to_s + " listings",
	    :expense_type => "Etsy Fees",
	    :vendor => "Etsy",
	    :amount => listings_amount.round(2)
	    })
	end

	if multiquantity_count > 0
	  Expense.create({
	    :date => date,
	    :name => "Multiquantity Listing Fees",
	    :description => multiquantity_count.to_s + " multi-quantity listings",
	    :expense_type => "Etsy Fees",
	    :vendor => "Etsy",
	    :amount => multiquantity_amount.round(2)
	    })
	end

	if promotedlistings_count > 0
	  Expense.create({
	    :date => date,
	    :name => "Promoted Listings",
	    :description => promotedlistings_count.to_s + " promoted listings",
	    :expense_type => "Advertising",
	    :vendor => "Etsy",
	    :amount => promotedlistings_amount.round(2)
	    })
	end

	if privatelisting_count > 0
	  Expense.create({
	    :date => date,
	    :name => "Private Listing Fees",
	    :description => privatelisting_count.to_s + " private listings",
	    :expense_type => "Etsy Fees",
	    :vendor => "Etsy",
	    :amount => privatelisting_amount.round(2)
	    })
	end
  end


end
