class QuizQuestion < ApplicationRecord
  belongs_to :quiz, :counter_cache => :questions_count
  belongs_to :question
end
