class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
    @question.answers.build
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to admin_questions_path, notice: "问题添加成功"
    else
      render :new
    end
  end

  def edit
    @question.answers.build if @question.answers.empty?
  end

  def update
    if @question.update(question_params)
      redirect_to admin_questions_path, notice: "问题更新成功"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :category_id, 
                  :answers_attributes => [:id, :title, :is_right, :_destroy])
  end

  def find_question
    @question = Question.find(params[:id])
  end


end
