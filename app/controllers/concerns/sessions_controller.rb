class SessionsController < Devise::SessionsController

  protect_from_forgery unless: -> { request.format.json? }

  def create
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        user = User.find_for_database_authentication(email: JSON.parse(params["user"])["email"])
        return invalid_login_attempt unless user

        if user.valid_password?(JSON.parse(params["user"])["password"])
          render json: {id: user.id, mobile_token: user.create_or_fetch_mobile_token }, success: true, status: :created
        else
          invalid_login_attempt
        end
      }
    end
  end

  def destroy
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        user = User.find_by_authentication_token(params[:auth_token])
        if user
          user.reset_authentication_token!
          render json: { message: 'Session deleted.' }, success: true, status: 204
        else
          render json: { message: 'Invalid token.' }, status: 404
        end
      }
    end
  end

  protected
  def invalid_login_attempt
    warden.custom_failure!
    render json: { success: false, message: 'Error with your login or password' }, status: 401
  end

  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end
end
