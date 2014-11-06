class Api::NotificationsController < Api::ApplicationController
  before_action :require_login
  def index
    @notifications = current_user.notifications.order('id desc').limit(5)
    render template: 'api/notifications'
  end

  def read(id)
    render 'notification read' if Notification.find(id).to_read
  end
end
