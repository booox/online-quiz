class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :notification_count
  before_action :set_timezone

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: "你不是管理员，无权访问此页面!"
    end
  end

  def set_timezone
    if current_user && current_user.profile.time_zone != ""
      Time.zone = current_user.profile.time_zone
    else
      Time.zone = 'Beijing'
    end
  end

  private

  def notification_count
    current_user.notifications.not_read.size
  end
end
