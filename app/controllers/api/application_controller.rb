class Api::ApplicationController < ActionController::Base
  require 'pusher'

  Pusher.app_id = ENV['PUSHER_APP']
  Pusher.key = ENV['PUSHER_KEY']
  Pusher.secret = ENV['PUSHER_SECRET']
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
    if !current_user
      render json: "{ 'error': 'you must be logged in!'}",
        status: :unprocessable_entity
    end
  end

  def check_owner(obj)
    if obj.user != current_user
      flash[:msg] = [ "You Do Not Own This #{ obj.class.to_s }" ]
      redirect_to root_url
    end
  end

  def is_owner?(obj)
    obj.user == current_user
  end

  def not_owner?(obj)
    obj.user != current_user
  end

  def send_notification(notification)
    user_channel = "user_#{notification.user_id}"
    Pusher.trigger(user_channel, 'notification', { notification: "notification created" })
  end

  helper_method :current_user, :is_logged_in?, :is_owner?

end
