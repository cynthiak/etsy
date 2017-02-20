module ExpensesHelper

  # Expenses ##############
  def get_expenses_array(expense_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = Expense.all.order("date").first.date
    end
    if end_date == nil
      end_date = Expense.all.order("date").last.date
    end
    if expense_type
      Expense.where(expense_type: expense_type, date: start_date..end_date)
    else
      Expense.where(date: start_date..end_date)
    end
  end

  def get_expenses(expense_type=nil, start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    if expense_type
      Expense.where(expense_type: expense_type, date: start_date..end_date).sum(:amount).round(2)
    else
      Expense.where(date: start_date..end_date).sum(:amount).round(2)
    end
  end
  def get_expenses_by_month(expense_type=nil, month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_expenses(expense_type, start_date, end_date)
  end
  def get_expenses_by_year(expense_type=nil, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_expenses(expense_type, start_date, end_date)
  end

  # Average Monthly Expenses ##############
  def get_average_monthly_expenses(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    (get_expenses(nil, start_date, end_date)/months(nil, start_date, end_date)).round(2)
  end
  def get_average_monthly_expenses_by_year(year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_average_monthly_expenses(start_date, end_date)
  end

  # Average Daily Expenses ##############
  def get_average_daily_expenses(start_date=nil, end_date=nil)
    if start_date == nil 
      start_date = get_first_sale_date
    end
    if end_date == nil
      end_date = get_last_sale_date
    end
    (get_expenses(nil, start_date, end_date)/days(nil, start_date, end_date)).round(2)
  end
  def get_average_daily_expenses_by_month(month)
    start_date = Date.new(month.year, month.month, 1)
    end_date = Date.civil(month.year, month.month, -1)
    return get_average_daily_expenses(start_date, end_date)
  end
  def get_average_daily_expenses_by_year(year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    return get_average_daily_expenses(start_date, end_date)
  end

  # By Expense Type ##############
  def get_expense_types
    Expense.order(:expense_type).pluck(:expense_type).uniq
  end

  def get_expenses_percentage_by_type(expense_type, start_date=nil, end_date=nil)
    type = get_expenses(expense_type, start_date, end_date)
    total = get_expenses(nil, start_date, end_date)
    return ((type/total)*100).round(2)
  end

  def get_expenses_percentage_by_type_by_year(expense_type, year)
    start_date = Date.new(year, 1, 1)
    end_date = Date.civil(year, 12, -1)
    get_expenses_percentage_by_type(expense_type, start_date, end_date)
  end


end