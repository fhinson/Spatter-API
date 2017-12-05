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
    render json:c.id
  end

  def upvote_comment
    comment = Comment.find(params[:comment_id])
    comment.upvotes = comment.upvotes + 1
    comment.save!
    user = User.find(params[:user_id])
    user.add_upvoted_comment(comment)
    render nothing:true
  end

  def downvote_comment
    comment = Comment.find(params[:comment_id])
    comment.downvotes = comment.downvotes + 1
    comment.save!
    user = User.find(params[:user_id])
    user.add_downvoted_comment(comment)
    render nothing:true
  end

  def un_upvote_comment
    comment = Comment.find(params[:comment_id])
    comment.upvotes = comment.upvotes - 1
    comment.save!
    user = User.find(params[:user_id])
    user.remove_upvoted_comment(comment)
    render nothing:true
  end

  def un_downvote_comment
    comment = Comment.find(params[:comment_id])
    comment.downvotes = comment.downvotes - 1
    comment.save!
    user = User.find(params[:user_id])
    user.remove_downvoted_comment(comment)
    render nothing:true
  end

  def flag_comment
    comment = Comment.find(params[:comment_id])
    comment.flags = comment.flags + 1
    comment.save!
    user = User.find(params[:user_id])
    user.add_flagged_comment(comment)
    render nothing:true
  end

  def create
    @game = Game.new()

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @game.update()
        format.html { redirect_to @game, notice: 'game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
end
