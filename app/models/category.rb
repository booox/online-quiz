class Category < ApplicationRecord
  before_create :generate_uuid

  validates_presence_of :title

  has_many :questions

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
