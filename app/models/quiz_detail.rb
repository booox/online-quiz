# == Schema Information
#
# Table name: quiz_details
#
#  id               :integer          not null, primary key
#  quiz_id          :integer
#  question_id      :integer
#  choice_id        :integer
#  is_correct       :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  quiz_question_id :integer
#

class QuizDetail < ApplicationRecord
  belongs_to :quiz
  # belongs_to :quiz_question

  scope :quiz_correct_answers, ->(q, u) { where(quiz_id: q, user_id: u, is_correct: true )}
  scope :quiz_wrong_answers, ->(q, u) { where(quiz_id: q, user_id: u, is_correct: false )}
  scope :quiz_answered_questions, ->(q, u) { where(quiz_id: q, user_id: u )}

  scope :wrong_answers, ->(u) { where(user_id: u, is_correct: false ) }
end
