module Admin::QuizzesHelper
  def display_quiz_hide_icon(quiz)
    publish = content_tag(:i, nil, class: 'fa fa-globe', 'aria-hidden': true, id: "quiz-hide-#{quiz.id}")
    hide = content_tag(:i, nil, class: 'fa fa-lock', 'aria-hidden': true, id: "quiz-hide-#{quiz.id}")
    quiz.is_hidden? ? hide : publish
  end
end
