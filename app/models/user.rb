class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorites
  has_many :favorite_questions, :through => :favorites, :source => :question

  def admin?
    is_admin
  end

  def favorite_question?(question)
    self.favorite_questions.include?(question)
  end
end
