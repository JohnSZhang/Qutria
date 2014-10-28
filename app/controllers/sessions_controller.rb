class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_creds(session_params)
    if user
      login(user)
      redirect_to root_url
    else
      flash[:msg] = "incorrect username or password"
      @username = session_params[:username]
      render :new
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
