class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_creds(session_params)
    if @user
      login(@user)
      render template: "api/user"
    else
      render json: '{ "error": "cannot login!"}', status: :unprocessable_entity
    end
  end

  def destroy
    self.current_user.reset_session_token
    session[:token] = ''
    render json: '{ "msg": "logged out!"}'
  end

  def current
    if is_logged_in?
      @user = current_user
      render template: "api/user"
    else
      render json: '{ "msg": "not signed in"}'
    end
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end

end
