class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_user
    render json:User.find(params[:user_id])
  end
end
