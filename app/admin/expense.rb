ActiveAdmin.register Expense do

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
    f.inputs 'Expense' do
      f.input :product_type, collection: ProductType.order('product_type ASC')
      f.input :order, collection: Order.order('sale_date DESC')
      f.input :order_item, collection: OrderItem.order('id DESC')
      f.input :date
      f.input :name
      f.input :description
      f.input :expense_type
      f.input :vendor
      f.input :amount
    end
    f.actions
  end



end
