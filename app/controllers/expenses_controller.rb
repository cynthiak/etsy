class ExpensesController < ApplicationController
  def index
  end

  def new
    name = "Shipping"
    expense_type = "Shipping"
    vendor = "USPS"
    @product_types = ProductType.all.order(:product_type)

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

    if @expense.save
      redirect_to new_expense_path, alert: "Expense added successfully. Add another expense."
    else
      redirect_to new_expense_path, alert: "Error creating expense."
    end
  end

  def import
    Expense.import(params[:file])
    redirect_to expenses_url, notice: "Fees imported."
  end
end
