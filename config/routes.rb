Rails.application.routes.draw do
  root 'games#index'
  get '/todays_games', to: 'games#get_todays_games'
end
