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
end
