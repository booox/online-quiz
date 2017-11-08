# == Schema Information
#
# Table name: feelings
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  value       :string           default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Feeling < ApplicationRecord
  belongs_to :user
  belongs_to :question
end
