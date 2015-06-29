class Product < ActiveRecord::Base

  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  has_many :variations
  has_many :listings

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute *column_names


  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      product = Product.find_by(product_name: row[0])
      if (product)
        product.update({
            :dimsum=>row[1],
            :description=> row[2],
            :file=> row[3],
            :product_type=> row[4],
            :occasion=> row[5]
          })
      else
        product = Product.create({
            :product_name=> row[0],
            :dimsum=>row[1],
            :description=> row[2],
            :file=> row[3],
            :product_type=> row[4],
            :occasion=> row[5]
          })
      end
      product.save!
    end
  end

  def get_listings
    @listings = Listing.where(product: self)
  end

  def get_order_items
    @listings = self.get_listings

    #get orders that match each of these listings
  end

  def total_sales
    # get all listings for this product
    # add up the "quantity" for all order items (this includes shipping and sales tax, and takes into account any coupons)
  end


end
