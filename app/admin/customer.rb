ActiveAdmin.register Customer do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  form do |f|

    f.inputs 'Customer' do
      f.input :first_name, :as => :string
      f.input :last_name, :as => :string
      f.input :etsy_username, :as => :string
      f.input :email, :as => :string
      f.input :customer_type, :as => :string
      f.input :company, :as => :string
      f.input :source, :as => :string
      f.input :instagram, :as => :string
      f.input :ship_name, :as => :string
      f.input :ship_address1, :as => :string
      f.input :ship_address2, :as => :string
      f.input :ship_city, :as => :string
      f.input :ship_state, :as => :string
      f.input :ship_zipcode, :as => :string
      f.input :ship_country, :as => :string
    end
    f.actions
  end


end
