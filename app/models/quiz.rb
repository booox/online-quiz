class Quiz < ApplicationRecord
  validates_presence_of :title, :category_id, :type_ids
  # validates :question_count, numericality: { :greater_than_or_equal_to => 0}

  has_many :quiz_questions
  has_many :questions, :through => :quiz_questions

  belongs_to :category
  has_many :quiz_details
  has_many :answers, :through => :quiz_details
end
