class Admin::QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_quiz, only: [:show, :edit, :update, :destroy, :hide_and_publish]

  def index
    @quizzes = Quiz.includes(:quiz_questions).all
  end

  def show
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)

    if @quiz.save
      Question.where("category_id = ?", quiz_params[:category_id]).each do |question_id|
        @quiz.questions << question_id
      end
      redirect_to admin_quizzes_path, notice: "试卷添加成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to admin_quizzes_path, notice: "试卷更新成功"
    else
      render :edit
    end
  end

  def destroy
    @quiz.destroy
    redirect_to admin_quizzes_path
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

  private

  def quiz_params
    params.require(:quiz).permit(:title, :category_id )
  end

  def find_quiz
    @quiz = Quiz.includes(:quiz_questions).find(params[:id])
  end

end
