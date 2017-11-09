module NotificationsHelper
  def display_notification_status(notification)
    if notification.is_read
      content_tag(:span, "已读", class: "label label-read", id: "notification-#{notification.id}")
    else
      content_tag(:span, "未读", class: "label label-unread", id: "notification-#{notification.id}")
    end
  end

  def display_notification_mark_all_as_read(not_read_notifications_count)
    if not_read_notifications_count > 0
      link_to("全部标记已读", mark_all_as_read_notifications_path, class: "btn btn-primary btn-xs", id: "mark-all-as-read", method: :post, remote: true)
    end
  end

  def display_notification_mark_as_read(notification)
    if ! notification.is_read
      link_to("标记已读", mark_as_read_notification_path(notification), class: "btn btn-primary btn-xs", id: "mark-as-read-#{notification.id}", method: :post, remote: true)
    end
  end
end
