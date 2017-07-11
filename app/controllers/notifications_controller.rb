class NotificationsController < ApplicationController
  def index
    @count = Notification.unread_count(current_user)
    @notifications = Notification.where(user: current_user)
  end
end
