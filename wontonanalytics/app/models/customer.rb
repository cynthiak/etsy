class Customer < ActiveRecord::Base
  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  has_many :orders

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :etsy_username

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible :first_name, :last_name, :etsy_username, :email, :source, :ship_name, :ship_address1, :ship_address2, :ship_city, :ship_state, :ship_zipcode, :ship_country

end
