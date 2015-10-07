module ExpensesHelper
  def get_expenses
    Expense.all
  end

  def get_expenses_number
    Expense.all.sum(:amount).round(2)
  end

  def get_expense_types
    Expense.order(:expense_type).pluck(:expense_type).uniq
  end

  def get_expenses_by_type(expense_type)
    Expense.where(expense_type: expense_type).sum(:amount).round(2)
  end

end