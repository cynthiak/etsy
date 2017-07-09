ActiveAdmin.register Listing do

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
    column :listing_type
    column :etsy_listing_variation
    column :product
    column :variation
    column :item_name
    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end




  form do |f|

    f.inputs 'Listing' do
      f.input :product, collection: Product.order('product_name ASC')
      f.input :variation
      f.input :listing_type, :as => :string
      f.input :etsy_listing_variation, :as => :string
      f.input :item_name, :as => :string
    end
    f.actions
  end


end
