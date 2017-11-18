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
#  start_number    :integer
#  end_number      :integer
#  given_number    :integer
#  start_time      :datetime
#  end_time        :datetime
#  is_random       :boolean          default(FALSE)
#

class Quiz < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :category_id, presence: true, if: :no_quiz_type?
  validates :cover, presence: true
  # validates :end_number, presence: true, if: :has_start_number?
  validates :end_number, numericality: { greater_than_or_equal_to: :start_number}, if: :has_start_number?

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

  def has_start_number?
    self.start_number.present?
  end
end
