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

  def leaderboard
    @quiz = Quiz.find(params[:id])
    key = @quiz.id

    @leaders = Leaderboard.top(key).paginate( :page => params[:page], per_page: 10 )
    @current_user_score = Leaderboard.get_user_score(key, current_user).to_i
    @current_user_rank = Leaderboard.get_user_rank(key, current_user)
  end

end
