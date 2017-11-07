module QuizQuestionsHelper

  # for index page
  def display_question_icon(question_id, correct_ids, wrong_ids)
    if correct_ids.include?(question_id)
      content_tag(:i, nil, class: 'fa fa-check-circle', 'aria-hidden': true)
    elsif wrong_ids.include?(question_id)
      content_tag(:i, nil, class: 'fa fa-times', 'aria-hidden': true)
    else
      content_tag(:i, nil, class: 'fa fa-circle-o', 'aria-hidden': true)
    end
  end

  # for show page
  def display_question_favorite(not_favorite, is_favorite, quiz_type)
    if !quiz_type.present?    # quiz_type: favorite , wrong
      if not_favorite
        content_tag(:i, nil, class: 'fa fa-star-o', id: "favorite_icon", 'aria-hidden': true)
      elsif is_favorite
        content_tag(:i, nil, class: 'fa fa-star', id: "favorite_icon", 'aria-hidden': true)
      end
    end
  end


  # for show page
  def display_quiz_title(quiz, quiz_type)
    if !quiz_type.present?
      quiz.title
    elsif quiz.title == "_user_favorite_#{current_user.id}"
      t("site.my_favorite")
    elsif quiz.title == "_user_wrong_#{current_user.id}"
      t("site.my_wrong")
    end
  end


  # for quiz question show page
  def display_user_feeling(quiz, question, user_feeling)
    feelings = [["good", "😄", "So easy"], ["normal", "😐", "还OK"], ["bad", "😭", "崩溃了"]]

    concat(content_tag(:div, class: "panic-panel-body ui-selectable", id: "selectable" ) do
      feelings.each do |feeling|

        concat( link_to( feeling_quiz_question_path(quiz_id: quiz.id, id: question.id, feeling_value: "#{feeling[0]}" ), method: :post, class: "item ui-selectee #{ 'ui-selected' if user_feeling == feeling[0] }", id: "item-#{feeling[0]}", remote: true) do

          concat(content_tag(:div, class: "ui-widget-content ui-selectee" ) do
            concat(content_tag(:span, feeling[1], class: "emoji ui-selectee" ))
            concat(content_tag(:span, feeling[2], class: "text ui-selectee" ))
          end)

        end)
      end
    end)

    return nil
  end


  # for show page
  def pretty_answer(answered, is_correct, right_answer_id, choice_id, answer_id)

    answered_css = ""

    # 已经回答过
    if answered
      # 回答正确
      if is_correct
        # answered_css = ( answer_id == choice_id ) ? "list-group-item-success" : ""
        if choice_id == answer_id
          answered_css = "list-group-item-success"
        end
      # 回答错误
      else
        # 选择的答案
        if choice_id == answer_id
          answered_css = "list-group-item-danger"
        # 没有选择，但却是正确的答案
        elsif right_answer_id == answer_id
          answered_css = "list-group-item-success"
        end
      end
    end
  end
end
