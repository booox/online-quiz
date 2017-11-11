class Profile < ApplicationRecord
  validates :nickname, uniqueness: true
  belongs_to :user
end
