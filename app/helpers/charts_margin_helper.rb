module ChartsMarginHelper
  require 'json'

  # Margin By Month ###################################################################
  def get_margin_array_by_months(order_type=nil)
    margin_array = []
    get_months.each do |month|
      margin_array.push(get_margin_by_month(order_type, month).round(2))
    end
    return margin_array
  end

  def get_margin_percentage_array_by_month(order_type=nil)
    margin_percentage_array = []
    get_months.each do |month|
      pct = get_margin_percentage_by_month(order_type, month)
      if !pct.to_f.nan?
        pct = pct.round(0)
      end
      margin_percentage_array.push(pct)
    end
    return margin_percentage_array
  end

end