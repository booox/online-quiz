class Quiz < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :category_id, presence: true, if: :no_quiz_type?

  has_many :quiz_questions
  has_many :questions, :through => :quiz_questions

  belongs_to :category, optional: true

  has_many :quiz_details
  has_many :answers, :through => :quiz_details

  scope :no_quiz_type_quizzes, -> { where( quiz_type: "" ) }

  def is_hidden?
    is_hidden
  end

  def no_quiz_type?
    # white_words = ["favorite", "wrong"]
    !self.quiz_type.present?
  end
end
