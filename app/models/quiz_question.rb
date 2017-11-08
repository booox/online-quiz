# == Schema Information
#
# Table name: quiz_questions
#
#  id          :integer          not null, primary key
#  quiz_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class QuizQuestion < ApplicationRecord
  belongs_to :quiz  #, :counter_cache => :questions_count
  belongs_to :question
  # has_many :quiz_details #, class_name: 'QuizDetail', dependent: :destroy
end
