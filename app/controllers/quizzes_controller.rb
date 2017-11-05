class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def index
    @quizzes = Quiz.where(is_hidden: false).includes(:quiz_questions).all
  end

  def reset
    @quiz = Quiz.find(params[:id])
    QuizDetail.where(user_id: current_user, quiz_id: @quiz).destroy_all
    flash[:notice] = "成功清理答题记录"
    redirect_to quiz_questions_path(@quiz)
  end

end
