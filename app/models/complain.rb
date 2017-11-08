# == Schema Information
#
# Table name: complains
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  content     :text
#  is_replied  :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  quiz_id     :integer
#

class Complain < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one :conversation
end
