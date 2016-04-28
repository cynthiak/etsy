class DashboardController < ApplicationController

  def index
    @start_date = Order.all.order("sale_date").first.sale_date
    @end_date = Order.all.order("sale_date").last.sale_date

    @recent_period_start_date = 3.months.ago.at_beginning_of_month.to_date 
    @recent_period_end_date = 1.months.ago.end_of_month.to_date

    @current_month_start_date = 0.months.ago.at_beginning_of_month.to_date 
    @current_month_end_date = 0.months.ago.end_of_month.to_date
  end

end
