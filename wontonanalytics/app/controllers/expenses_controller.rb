class ExpensesController < ApplicationController
  def index
  end

  def new
  end

  def import
    Expense.import(params[:file])
    redirect_to expenses_url, notice: "Fees imported."
  end
end
