class Api::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login(user)
    session[:token] = user.reset_session_token
  end

  def current_user
    return nil unless session[:token]
    User.find_by_session_token(session[:token])
  end

  def is_logged_in?
    !!current_user
  end

  def require_login
    redirect_to new_session_url unless is_logged_in?
  end

  def check_owner(obj)
    if obj.user != current_user
      flash[:msg] = [ "You Do Not Own This #{ obj.class.to_s }" ]
      redirect_to root_url
    end
  end

  def is_owner?(obj)
    obj.user != current_user
  end

  helper_method :current_user, :is_logged_in?, :is_owner?

end
