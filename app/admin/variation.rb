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
