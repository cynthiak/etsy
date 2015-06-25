class Product < ActiveRecord::Base
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


end
