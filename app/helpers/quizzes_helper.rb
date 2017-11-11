module QuizzesHelper
  def display_quiz_cover(quiz)
    quiz.cover.present? ? quiz.cover.thumb.url : "cover-image.png"
  end
end
