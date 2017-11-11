module ApplicationHelper
  def display_favorite_link
    user_quiz_helper = current_user.get_user_quiz("favorite")

    if user_quiz_helper
      user_quiz_questions_helper = current_user.get_user_quiz("favorite").try(:questions).first.try(:id)
      if user_quiz_questions_helper
        link_to( "我的收藏", quiz_question_path(user_quiz_helper, user_quiz_questions_helper) )
      else
        link_to( "我的收藏", quiz_questions_path(user_quiz_helper))
      end
    else
      link_to( "我的收藏", "/")
    end
  end

  def display_wrong_link
    user_quiz_helper = current_user.get_user_quiz("wrong")

    if user_quiz_helper
      user_quiz_questions_helper = current_user.get_user_quiz("wrong").try(:questions).first.try(:id)
      if user_quiz_questions_helper
        link_to( "我的错题", quiz_question_path(user_quiz_helper, user_quiz_questions_helper) )
      else
        link_to( "我的错题", quiz_questions_path(user_quiz_helper))
      end
    else
      link_to( "我的错题", "/")
    end
  end

  def display_notification_count(notification_count)
    if notification_count > 0
      concat(content_tag(:i, nil, class: 'fa fa-bell orange', 'aria-hidden': true))
      content_tag(:span, "#{notification_count}", id: "not_read_notifications_count", class: "orange")
    else
      content_tag(:i, nil, class: 'fa fa-bell', 'aria-hidden': true)
    end
  end

  def progressBar(num, total)
    ((num.round(2) / total) * 100).to_i
  end

end
