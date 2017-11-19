class Admin::QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_quiz, only: [:show, :edit, :update, :destroy, :hide_and_publish, :statistics]

  def index
    @quizzes = Quiz.includes(:quiz_questions).no_quiz_type_quizzes
  end

  def show
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)

    start_number = params[:quiz][:start_number].to_i
    end_number = params[:quiz][:end_number].to_i
    given_number = params[:quiz][:given_number].to_i
    is_random = params[:quiz][:is_random]

    offset_number = start_number > 0 ? (start_number - 1) : 0  # offset number
    limit_number = 0  # the questions number that user want to retrieve

    # check number
    if start_number > 0 && end_number > 0
      if given_number > 0
        limit_number = ( given_number < (end_number - start_number) ) ? given_number : (end_number - start_number)
        puts "a: limit_number: #{limit_number}"
      else
        limit_number = end_number - start_number + 1
        puts "b: limit_number: #{limit_number}"
      end
    else
      if given_number > 0
        limit_number = given_number
        puts "c: limit_number: #{limit_number}"
      end
    end


    if @quiz.save
      questions = Question.where("category_id = ?", quiz_params[:category_id])

      questions = questions.offset(offset_number).limit(limit_number)

      # check random
      if is_random
        questions = questions.sample(limit_number)
      end

      questions.each do |question_id|
        @quiz.questions << question_id
      end
      redirect_to admin_quizzes_path, notice: t("site.admin.quiz.create_success")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to admin_quizzes_path, notice: t("site.admin.quiz.update_success")
    else
      render :edit
    end
  end

  def destroy
    @quiz.destroy

    Leaderboard.prefixs.each do |prefix|
      Leaderboard.del_key("#{prefix}:quiz:#{@quiz.id}")   # remove leaderboard
    end

    redirect_to admin_quizzes_path, warning: t("site.admin.quiz.delete_success")
  end

  def hide_and_publish
    @is_hidden = @quiz.is_hidden?

    if @is_hidden
      @quiz.is_hidden = false
    else
      @quiz.is_hidden = true
    end
    @quiz.save
  end

  def statistics
    @quiz_questions_size = @quiz.questions.size
    @statistics = Leaderboard.admin_statistics(@quiz.id).paginate( :page => params[:page], per_page: 35 )
  end

  private

  def quiz_params
    params.require(:quiz).permit( :title, :category_id, :cover,
                                  :start_number, :end_number, :given_number,
                                  :is_random, :start_time, :end_time )
  end

  def find_quiz
    @quiz = Quiz.includes(:quiz_questions).find(params[:id])
  end

end
