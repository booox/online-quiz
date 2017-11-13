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
  validates :nickname, uniqueness: true
  belongs_to :user
end
