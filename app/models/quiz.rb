# == Schema Information
#
# Table name: quizzes
#
#  id              :integer          not null, primary key
#  title           :string
#  category_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  questions_count :integer          default(0)
#  is_hidden       :boolean          default(TRUE)
#  quiz_type       :string           default("")
#  cover           :string
#

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

  mount_uploader :cover, CoverUploader

  def is_hidden?
    is_hidden
  end

  def no_quiz_type?
    # white_words = ["favorite", "wrong"]
    !self.quiz_type.present?
  end
end
