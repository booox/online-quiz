# == Schema Information
#
# Table name: types
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Type < ApplicationRecord
  validates_presence_of :title

  # has_many :questions
end
