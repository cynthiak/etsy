class Giveaway < ActiveRecord::Base
  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  belongs_to :product
  belongs_to :variation
  belongs_to :customer
  
end
