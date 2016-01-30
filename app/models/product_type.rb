class ProductType < ActiveRecord::Base

  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  has_many :products

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :product_type

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names

end
