class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_creds(session_params)
    if @user
      login(@user)
      render template: "api/user"
    else
      render json: { error: "no such user found!"}
    end
  end

  def destroy
    self.current_user.reset_session_token
    session[:token] = ''
    redirect_to root_url
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end

end
