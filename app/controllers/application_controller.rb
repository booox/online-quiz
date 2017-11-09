class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :notification_count

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: "你不是管理员，无权访问此页面!"
    end
  end

  private

  def notification_count
    current_user.notifications.not_read.size
  end
end
