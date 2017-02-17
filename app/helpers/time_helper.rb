module TimeHelper

  # Sales Dates ##############
  def get_first_sale_date(order_type=nil)
    if order_type != nil
      Order.where(order_type: order_type).order("sale_date").first.sale_date
    else
      Order.all.order("sale_date").first.sale_date
    end
  end

  def get_last_sale_date(order_type=nil)
    if order_type != nil
      Order.where(order_type: order_type).order("sale_date").last.sale_date
    else
      Order.all.order("sale_date").last.sale_date
    end
  end

  def get_first_sale_date_in_year(order_type=nil, year)
    first_day = Date.new(year, 1, 1)
    last_day = Date.new(year, 12, 31)
    if order_type != nil
      Order.where(order_type: order_type).where(sale_date: first_day..last_day).order("sale_date").first.sale_date
    else
      Order.where(sale_date: first_day..last_day).order("sale_date").first.sale_date
    end
  end
  def get_last_sale_date_in_year(order_type=nil, year)
    first_day = Date.new(year, 1, 1)
    last_day = Date.new(year, 12, 31)
    if order_type != nil
      Order.where(order_type: order_type).where(sale_date: first_day..last_day).order("sale_date").last.sale_date
    else
      Order.where(sale_date: first_day..last_day).order("sale_date").last.sale_date
    end
  end

  # Years ##############
  def get_years # array of years arrive
    Order.select("sale_date").map{ |item| item.sale_date.year }.uniq
  end

  # Months ##############
  def months(order_type=nil, start_date=nil, end_date=nil) # count months active
    if start_date == nil
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    if order_type
      orders = Order.where(order_type: order_type, sale_date: start_date..end_date).order("sale_date")
      if !orders.empty?
        start_date = orders.first.sale_date
        end_date = orders.last.sale_date
      else
        start_date = get_first_sale_date(order_type)
        end_date = get_last_sale_date(order_type)
      end
    else
      start_date = Order.where(sale_date: start_date..end_date).order("sale_date").first.sale_date
      end_date = Order.where(sale_date: start_date..end_date).order("sale_date").last.sale_date
    end
    return (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month) + 1
  end

  def get_months(start_date=nil, end_date=nil)
    if start_date
      date_from = start_date
    else
      date_from = Date.parse('2015-4-1')
    end
    if end_date
      date_to = end_date
    else
      date_to = get_last_sale_date
    end
    date_range = date_from..date_to

    date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    return date_months
  end

  def get_months_array #for chart
    date_months = get_months
    date_months.map {|d| d.strftime "%b %Y" }
  end

  def get_month_names_array
    ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  end

  def get_months_by_year(year_input) #for chart
    start_date = Date.new(year_input, 1, 1)
    if year_input == get_last_sale_date.year
      end_date = get_last_sale_date
    else
      end_date = Date.new(year_input, 12, 31)
    end
    date_months = get_months(start_date, end_date)
  end

  def get_months_left_in_year
    date_from = get_last_sale_date
    date_to = Date.new(date_from.year, 12, 31)
    date_range = date_from..date_to
    date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    return date_months
  end

  # Days ##############
  def days(order_type=nil, start_date=nil, end_date=nil)
    if start_date == nil
      start_date = get_first_sale_date(order_type)
    end
    if end_date == nil
      end_date = get_last_sale_date(order_type)
    end
    if order_type
      orders = Order.where(order_type: order_type, sale_date: start_date..end_date).order("sale_date")
      if !orders.empty?
        start_date = orders.first.sale_date
        end_date = orders.last.sale_date
      else
        start_date = get_first_sale_date(order_type)
        end_date = get_last_sale_date(order_type)
      end
    else
      start_date = Order.where(sale_date: start_date..end_date).order("sale_date").first.sale_date
      end_date = Order.where(sale_date: start_date..end_date).order("sale_date").last.sale_date
    end
    return (end_date - start_date) + 1
  end

  def get_days_left_in_year_count # as of end of last month
    last_month = get_last_sale_date - 1.month
    date_from = Date.civil(last_month.year, last_month.month, -1)
    date_to = Date.new(date_from.year, 12, 31)
    date_range = date_from..date_to
    days = (date_from - date_to).to_i * -1
    return days
  end

  def get_days_of_month_array
    Array(1...32)
  end

  def get_days_of_month_array_by_month(month)
    # if month is current month, only show up to last sale date (used in month cumulative revenue chart)
    if get_last_sale_date.mon == month.month && get_last_sale_date.year == month.year
      Array(1...get_last_sale_date.mday+1)
    else
      Array(1...32)
    end
  end

  def get_last_x_dates_array(number_of_days=60) 
    # for daily rev chart on dashboard
    end_date = get_last_sale_date
    start_date = end_date - number_of_days
    last_x_dates_array = []
    while start_date != (end_date + 1) do
      last_x_dates_array.push(start_date)
      start_date = start_date + 1
    end
    return last_x_dates_array
  end

  def get_last_x_dates_as_strings_array(number_of_days=60)
    # for daily rev chart on dashboard
    end_date = get_last_sale_date
    start_date = end_date - number_of_days
    last_x_dates_array = []
    while start_date != (end_date + 1) do
      last_x_dates_array.push(start_date.strftime("%b %d"))
      start_date = start_date + 1
    end
    return last_x_dates_array
  end


  
end