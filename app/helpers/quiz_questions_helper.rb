module QuizQuestionsHelper
  def pretty_answer(answered, is_correct, right_answer_id, choice_id, answer_id)
    # answered ? ( correct_answer ? "list-group-item-success" : "list-group-item-danger") : ""

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
