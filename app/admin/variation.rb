ActiveAdmin.register Variation do

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
    column :product_type
    column :style
    column :gender
    column :color
    column :size
    column :quantity
    column :device
    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end




  form do |f|

    f.inputs 'Variation' do
      f.input :style, :as => :string
      f.input :gender, :as => :string
      f.input :color, :as => :string
      f.input :size, :as => :string
      f.input :quantity, :as => :number
      f.input :device, :as => :string
      f.input :product_type
    end
    f.actions
  end

end
