class QuizDetail < ApplicationRecord
  belongs_to :quiz
  # belongs_to :quiz_question

  scope :quiz_correct_answers, ->(q, u) { where(quiz_id: q, user_id: u, is_correct: true )}
  scope :quiz_wrong_answers, ->(q, u) { where(quiz_id: q, user_id: u, is_correct: false )}
  scope :quiz_answered_question, ->(q, u) { where(quiz_id: q, user_id: u )}

  scope :wrong_answers, ->(u) { where(user_id: u, is_correct: false ) }
end
