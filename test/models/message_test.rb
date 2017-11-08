# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  sender_id       :integer
#  recipient_id    :integer
#  subject         :string
#  conversation_id :integer
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_read         :boolean          default(FALSE)
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
