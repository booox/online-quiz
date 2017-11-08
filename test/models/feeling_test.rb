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

require 'test_helper'

class FeelingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
