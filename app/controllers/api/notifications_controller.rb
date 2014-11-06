class Api::NotificationsController < Api::ApplicationController
  before_action :require_login
  def index
    @notification_count = current_user.notifications.where(read: false).count
    @notifications = current_user.notifications.where(read: false).order('id desc').page(1)
    render template: 'api/notifications'
  end

  def read
    puts 'reading notification'
   if Notification.find(params[:id]).to_read
     render text: 'notification read'
   else
     render text: 'cannot read'
   end
  end
end
