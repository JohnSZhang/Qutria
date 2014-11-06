class Api::NotificationsController < Api::ApplicationController
  before_action :require_login
  def index
    @notification_count = current_user.notifications.count
    @notifications = current_user.notifications.order('id desc').page(1)
    render template: 'api/notifications'
  end

  def read(id)
    render 'notification read' if Notification.find(id).to_read
  end
end
