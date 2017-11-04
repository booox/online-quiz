class QuizQuestion < ApplicationRecord
  belongs_to :quiz  #, :counter_cache => :questions_count
  belongs_to :question
  # has_many :quiz_details #, class_name: 'QuizDetail', dependent: :destroy
end
