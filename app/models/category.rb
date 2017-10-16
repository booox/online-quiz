class Category < ApplicationRecord
  before_create :generate_uuid

  validates_presence_of :title

  has_many :questions
  has_many :quizzes

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
