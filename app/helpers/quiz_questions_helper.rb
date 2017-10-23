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
  def display_question_favorite(not_favorite, is_favorite)
    if not_favorite
      content_tag(:i, nil, class: 'fa fa-star-o', id: "favorite_icon", 'aria-hidden': true)

    elsif is_favorite
      content_tag(:i, nil, class: 'fa fa-star', id: "favorite_icon", 'aria-hidden': true)
    end
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
