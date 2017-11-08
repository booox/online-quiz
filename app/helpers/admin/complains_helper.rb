module Admin::ComplainsHelper
  def display_complain_conversation(complain)
    if complain.is_replied
      link_to("Replied", admin_conversation_path( complain.conversation, complain_id: complain.id ), class: "btn btn-success btn-xs")
    else
      link_to("Reply", new_admin_conversation_path( complain_id: complain.id ), class: "btn btn-danger btn-xs")
    end
  end

  def message_quote_complain(complain)
    html = ""
    html += ""
  end
end
