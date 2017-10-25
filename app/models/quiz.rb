class Quiz < ApplicationRecord
  validates_presence_of :title, :category_id

  has_many :quiz_questions
  has_many :questions, :through => :quiz_questions

  belongs_to :category

  has_many :quiz_details
  has_many :answers, :through => :quiz_details

  def is_hidden?
    is_hidden
  end
end
