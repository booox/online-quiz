# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  complain_id :integer
#

class Conversation < ApplicationRecord
  has_many :messages, inverse_of: :conversation, dependent: :destroy
  accepts_nested_attributes_for :messages, allow_destroy: true, reject_if: :all_blank
  belongs_to :complain

  def newest_message
    messages.order("created_at DESC").first
  end

  def first_message
    messages.order("created_at ASC").first
  end
end
