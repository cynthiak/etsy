module ExpensesHelper
  def get_expenses
    Expense.all
  end

  def get_expenses_number(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    Expense.where(date: start_date..end_date).sum(:amount).round(2)
  end

  def get_average_monthly_expenses(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    (get_expenses_number(start_date, end_date)/months(nil, start_date, end_date)).round(2)
  end

  def get_expense_types
    Expense.order(:expense_type).pluck(:expense_type).uniq
  end

  def get_expenses_by_type(expense_type)
    Expense.where(expense_type: expense_type).sum(:amount).round(2)
  end


end