class QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_quiz, only: [:reset, :leaderboard, :statistics]

  def index
    @quizzes = Quiz.where(is_hidden: false).includes(:quiz_questions).all
  end

  def reset
    QuizDetail.where(user_id: current_user, quiz_id: @quiz).destroy_all

    Leaderboard.prefixs.each do |prefix|
      Leaderboard.remove_element("#{prefix}:quiz:#{@quiz.id}", "user:#{current_user.id}")
    end

    flash[:notice] = "成功清理答题记录"
    redirect_to quiz_questions_path(@quiz)
  end

  def leaderboard
    key = "score:quiz:#{@quiz.id}"
    @leaders = Leaderboard.top(key).paginate( :page => params[:page], per_page: 35 )
    @current_user_score = Leaderboard.get_user_score(key, current_user).to_i
    @current_user_rank = Leaderboard.get_user_rank(key, current_user)
  end

  def statistics
    @quiz_questions_size = @quiz.questions.size
    statistics_key = "statistics:quiz:#{@quiz.id}"

    @current_user_statistics = Leaderboard.get_user_score(statistics_key, current_user).to_i
    @statistics = Leaderboard.top(statistics_key).paginate( :page => params[:page], per_page: 35 )
  end

  private

  def find_quiz
    @quiz = Quiz.find(params[:id])
  end

end
