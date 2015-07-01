class Cost < ActiveRecord::Base
  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  belongs_to :product
  belongs_to :variation

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names
end
