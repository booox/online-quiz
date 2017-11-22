# == Schema Information
#
# Table name: departments
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  alias           :string
#

class Department < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :organization
end
