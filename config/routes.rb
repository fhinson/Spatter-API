Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  get '/get_user', to: 'users#get_user'
  get '/todays_games', to: 'games#get_todays_games'
  get '/get_game_comments', to: 'games#get_game_comments'
  post '/add_game_comment', to: 'games#add_game_comment'
  post '/upvote_comment', to: 'games#upvote_comment'
  post '/downvote_comment', to: 'games#downvote_comment'
  post '/un_upvote_comment', to: 'games#un_upvote_comment'
  post '/un_downvote_comment', to: 'games#un_downvote_comment'
  post '/flag_comment', to: 'games#flag_comment'
end
