Rails.application.routes.draw do
  resources :comments

  resources :games

  post '/users', to: 'users#create'
  resources :users, only: [:show]

  devise_for :users, controllers: { sessions: 'sessions' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'registrations#new'
  end

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
