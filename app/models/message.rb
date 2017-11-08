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

class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  belongs_to :conversation
end
