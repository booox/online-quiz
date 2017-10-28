class QuizDetail < ApplicationRecord
  belongs_to :quiz
  # belongs_to :quiz_question

  scope :correct_answers, ->(q, u) { where(quiz_id: q, user_id: u, is_correct: true )}
  scope :wrong_answers, ->(q, u) { where(quiz_id: q, user_id: u, is_correct: false )}
  scope :answered_question, ->(q, u) { where(quiz_id: q, user_id: u )}
end
