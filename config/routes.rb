Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  get '/todays_games', to: 'games#get_todays_games'
  get '/get_game_comments', to: 'games#get_game_comments'
  post '/add_game_comment', to: 'games#add_game_comment'
  post '/upvote_comment', to: 'games#upvote_comment'
  post '/downvote_comment', to: 'games#downvote_comment'
end
