module ConversationsHelper
  def display_conversation_status(message)
    if message.is_read
      content_tag(:span, "已读", class: "label label-read")
    else
      content_tag(:span, "未读", class: "label label-unread")
    end
  end
end
