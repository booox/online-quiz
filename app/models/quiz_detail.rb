class QuizDetail < ApplicationRecord
  belongs_to :quiz
  # belongs_to :answer

  scope :correct_answers, ->(q) { where(quiz_id: q, is_correct: true )}
  scope :wrong_answers, ->(q) { where(quiz_id: q, is_correct: false )}
  scope :answered_question, ->(q) { where(quiz_id: q )}
end
