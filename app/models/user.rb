# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_user_quiz

  has_many :favorites
  has_many :favorite_questions, :through => :favorites, :source => :question

  has_many :feelings, dependent: :destroy
  has_many :complains, dependent: :destroy

  has_many :recieved_messages, class_name: "Message", foreign_key: "recipient_id"
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"

  has_many :notifications
  has_one :profile, dependent: :destroy


  def admin?
    is_admin
  end

  def favorite_question?(question)
    self.favorite_questions.include?(question)
  end

  def get_user_quiz(name)
    quiz = Quiz.where(title: user_quiz_title(name)).first
  end

  def user_quiz_title(name)
    "_user_#{name}_#{self.id}".to_s
  end

  def get_user_conversations
    user_conversations = []

    self.recieved_messages.each do |message|
      user_conversations << message.conversation
    end

    self.sent_messages.each do |message|
      user_conversations << message.conversation
    end
  end


  private

  def create_user_quiz
    ["favorite", "wrong"].each do |name|
      Quiz.create(title: self.user_quiz_title(name),
                quiz_type: name,
                is_hidden: true )
    end
  end

end
