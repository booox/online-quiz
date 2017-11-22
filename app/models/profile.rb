# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  nickname     :string
#  real_name    :string
#  organization :string
#  department   :string
#  wechat       :string
#  qq           :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Profile < ApplicationRecord
  validates :nickname, uniqueness: true, unless: :nickname_is_null?
  belongs_to :user

  enum organizations: %w(nb2j)
  enum departments: %w(17jzsg 17jzzsB)

  def nickname_is_null?
    !self.nickname.present?
  end
end
