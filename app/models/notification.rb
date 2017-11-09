# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  subject    :string
#  content    :text
#  is_read    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :user
  scope :is_read, -> { where(:is_read => true )}
  scope :not_read, -> { where(:is_read => false )}

  def self.send_notification(user, subject, content)
    user.notifications.create(subject: subject, content: content)
  end
end
