module ChartsExpensesHelper
  require 'json'

  # Expenses By Category
  def get_expenses_by_type_series
    expense_types = get_expense_types

    expenses_array_by_type_series = []
    expense_types.each do |expense_type|
      expenses_array_by_type_series.push(get_expenses(expense_type, nil, nil))
    end

    return expenses_array_by_type_series
  end

  # Expenses By Year
  def get_expenses_by_type_by_year_series
    expense_types = get_expense_types

    yearly_expenses_array_by_type = []

    expense_types.each do |expense_type|
      expenses_array = []
      get_years.each do |year|
        expenses_array.push(get_expenses_by_year(expense_type, year))
      end
      yearly_expenses_array_by_type.push({
        'name' => expense_type, 
        'data' => expenses_array,
        'lineWidth' => 2,
        'marker' => {
            'enabled' => false
          }
        })
    end
    return yearly_expenses_array_by_type.to_json
  end

  # Expenses By Month
  def get_expenses_by_type_by_month_series
    expense_types = get_expense_types

    monthly_expenses_array_by_type = []

    expense_types.each do |expense_type|
      expenses_array = []
      get_months.each do |month|
        expenses_array.push(get_expenses_by_month(expense_type, month))
      end
      monthly_expenses_array_by_type.push({
        'name' => expense_type, 
        'data' => expenses_array,
        'lineWidth' => 2,
        'marker' => {
            'enabled' => false
          }
        })
    end
    return monthly_expenses_array_by_type.to_json
  end

end