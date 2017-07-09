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


  index do
    column :id do |resource|
      link_to resource.id, resource_path(resource)
    end
    column :created_at
    column :full_name do |resource|
      name = ''.html_safe
      if resource.first_name
        name += resource.first_name + " " 
      end
      if resource.last_name
        name += resource.last_name
      end
      name
    end
    column :etsy_username
    column :customer_type
    column :email
    column :instagram
    column :company
    column :source
    column "Shipping Address" do |resource|
      address = ''.html_safe
      address += resource.ship_name.to_s + ', ' + resource.ship_address1.to_s + resource.ship_address2.to_s + ', ' + resource.ship_city.to_s + ', ' + resource.ship_state.to_s + ', ' + resource.ship_zipcode.to_s + ', ' + resource.ship_country.to_s
    end
    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end



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
