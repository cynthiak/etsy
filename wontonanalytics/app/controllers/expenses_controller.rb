class ExpensesController < ApplicationController
  def index
  	@expenses = Expense.all
  	@total_expenses = Expense.all.sum(:amount).round(2)
  	@total_etsy_fees = Expense.where(expense_type: "Etsy Fees").sum(:amount).round(2)
  	@total_advertising = Expense.where(expense_type: "Advertising").sum(:amount).round(2)
  end

  def new
  end

  def import
    Expense.import(params[:file])
    redirect_to expenses_url, notice: "Fees imported."
  end
end
