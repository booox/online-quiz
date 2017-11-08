# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  uuid       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  before_create :generate_uuid

  validates_presence_of :title

  has_many :questions
  has_many :quizzes

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
