class ExpensesController < ApplicationController
  def index
  end

  def new
    name = ""
    expense_type = "Materials"
    vendor = "Amazon"
    @product_types = ProductType.all.order(:product_type)
    @expense_types = Expense.order(:expense_type).uniq.pluck(:expense_type)
    @orders = Order.where(date_shipped: nil).order(sale_date: :desc)
    @order_items = OrderItem.where(date_shipped: nil)

    if params[:name]
      name = params[:name]
    end
    if params[:expense_type]
      expense_type = params[:expense_type]
    end
    if params[:vendor]
      vendor = params[:vendor]
    end
    @expense = Expense.new({
      date: Date.today,
      name: name,
      expense_type: expense_type,
      vendor: vendor
    })
  end

  def create
    expense_params = params[:expense]
    @expense = Expense.new(expense_params)

    # Update order item's cost
    order_item = OrderItem.find_by_id(params[:expense][:order_item_id])
    if order_item
      order_item.update_columns(cost: @expense.amount)
    end

    if @expense.save
      redirect_to new_expense_path, alert: "Expense '" + @expense.name + "'' added successfully. Add another expense."
    else
      redirect_to new_expense_path, alert: "Error creating expense" + @expense.name + "'."
    end
  end

  def import
    Expense.import(params[:file])
    redirect_to expenses_url, notice: "Fees imported."
  end
end
