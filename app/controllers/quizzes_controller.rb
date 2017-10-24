class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def index
    @quizzes = Quiz.where(is_hidden: false).includes(:quiz_questions).all
  end
end
