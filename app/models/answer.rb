# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer
#  title       :string
#  is_right    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ApplicationRecord
  validates :title, presence: true

  belongs_to :question

  scope :right_answer, -> { where( is_right: true ) }
end
