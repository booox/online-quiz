class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_user_quiz

  has_many :favorites
  has_many :favorite_questions, :through => :favorites, :source => :question

  has_many :feelings, dependent: :destroy

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

  private

  def create_user_quiz
    ["favorite", "wrong"].each do |name|
      Quiz.create(title: self.user_quiz_title(name),
                quiz_type: name,
                is_hidden: true )
    end
  end

end
