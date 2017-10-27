class GamesController < ApplicationController
  def index
    render json:"Spatter API"
  end

  def get_todays_games
    games = Game.all
    date = Date.today
    beginning_of_day = date.to_time.in_time_zone('America/New_York').beginning_of_day
    end_of_day = date.to_time.in_time_zone('America/New_York').end_of_day
    todays_games = games.where(date: beginning_of_day..end_of_day)
    render json: todays_games
  end
end
