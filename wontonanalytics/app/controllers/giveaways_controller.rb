class GiveawaysController < ApplicationController

  def index
    @total_items_given_away = Giveaway.sum(:quantity)
    @giveaways = Giveaway.all
  end

end
