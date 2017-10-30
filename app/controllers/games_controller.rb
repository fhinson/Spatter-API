class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

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

  def get_game_comments
    game = Game.find(params[:game_id])
    render json: game.comments
  end

  def add_game_comment
    game = Game.find(params[:game_id])
    text = params[:comment_text]
    c = Comment.new
    c.comment = text
    c.user_id = params[:user_id]
    c.save!
    game.comments << c
    game.save!
    render nothing:true
  end

  def upvote_comment
    comment = Comment.where(comment: params[:comment]).where(user_id: params[:user_id]).where(commentable_id: params[:game_id]).first
    comment.upvotes = comment.upvotes.to_i + 1
    comment.save!
    render nothing:true
  end

  def downvote_comment
    comment = Comment.where(comment: params[:comment]).where(user_id: params[:user_id]).where(commentable_id: params[:game_id]).first
    comment.downvotes = comment.downvotes.to_i + 1
    comment.save!
    render nothing:true
  end

  def un_upvote_comment
    comment = Comment.where(comment: params[:comment]).where(user_id: params[:user_id]).where(commentable_id: params[:game_id]).first
    comment.upvotes = comment.upvotes.to_i - 1
    comment.save!
    render nothing:true
  end

  def un_downvote_comment
    comment = Comment.where(comment: params[:comment]).where(user_id: params[:user_id]).where(commentable_id: params[:game_id]).first
    comment.downvotes = comment.downvotes.to_i - 1
    comment.save!
    render nothing:true
  end
end
