class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
		@notifications = current_user.notifications.order(created_at: :desc).paginate( :page => params[:page], per_page: 10 )
    @not_read_notifications_count = current_user.notifications.not_read.size
	end

	def mark_as_read
		@notification_id = params[:id]

		notification = Notification.find(@notification_id)
		notification.update(is_read: true)
    # @not_read_notifications_count = current_user.notifications.not_read.size
	end

	def mark_all_as_read
		current_user.notifications.not_read.update_all(is_read: true)
    # @not_read_notifications_count = current_user.notifications.not_read.size
	end

end
