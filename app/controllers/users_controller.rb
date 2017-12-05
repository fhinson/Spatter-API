class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery unless: -> { request.format.json? }

  # GET users/:id
  def show
    user = User.find(params[:id])
    raise ArgumentError.new "Access Denied" if !user.valid_mobile_token?(
      params[:mobile_token])
    render json: user
  end

  # POST /users
  def create
    respond_to do |format|
      format.json {
        user = User.new(JSON.parse(params[:user]))
        if user.save
          render json: {id: user.id, mobile_token: user.create_or_fetch_mobile_token}, success: true, status: :created
          return
        else
          warden.custom_failure!
          render json: {errors: user.errors.full_messages}, status: 404
        end
      }
    end
  end
end
