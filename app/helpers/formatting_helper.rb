module FormattingHelper

  def format_money(number)
    return "$" + number_with_delimiter(number.round(2)).to_s
  end

  def format_percentage(number)
    return number_with_delimiter(number.round(2)).to_s + "%"
  end

end