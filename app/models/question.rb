class Question < ApplicationRecord

  validates_presence_of :title, :category_id
  validate :check_answers

  has_many :answers, inverse_of: :question, :dependent => :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  belongs_to :category
  belongs_to :type

  has_many :favorites
  has_many :favorite_users, :through => :favorites, :source => :user

  # has_many :quiz_questions
  # has_many :quizzes, :through => :quiz_questions



  private

  def check_answers
    if self.answers.empty?
      self.errors.add(:base, "至少需要一个答案")
    end
  end
end
