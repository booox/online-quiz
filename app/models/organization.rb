# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alias      :string
#

class Organization < ApplicationRecord
  validates :title, presence: true

  has_many :departments, inverse_of: :organization, dependent: :destroy
  accepts_nested_attributes_for :departments, allow_destroy: true

end
