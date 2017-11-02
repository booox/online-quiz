require 'csv'
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

  def import
    # 获取 Category & Type
    categories = Category.pluck(:title, :id)
    types = Type.pluck(:title, :id)

    # 导入题库字段列表
    # 其中 answer_x 为可增字段，修改 x 的数字即可，范围为 1-9
    # 问题,类型,题型,answer_1,answer_2,answer_3,right_answer
    csv_file = params[:csv_file]
    csv_rows = CSV.read(csv_file.path, headers: true)

    headers = csv_rows.headers

    answers = []
    headers.each do |header|
      header.match(/answer_[1-9]/) ? answers << header : ""
    end

    success = 0
    failed_records = []

    # i = 0
    CSV.foreach(csv_file.path, headers: true) do |row|
      # if i > 5 then
      #   break
      # end
      # i += 1

      # 获取 Category id & type id
      category_id = nil
      categories.each do |category|
        category_id = category[0].include?(row["类别"]) ? category[1] : nil
        if category_id
          break
        end
      end

      type_id = nil
      types.each do |type|
        type_id = type[0].include?(row["题型"]) ? type[1] : nil
        if type_id
          break
        end
      end


      right_answer = row["right_answer"]
      answers_attributes = []

      answers.each do |answer|
        answer_number = answer.split('_')[1]
        answers_attributes << {title: row[answer],
                               is_right: right_answer == answer_number ? true : false}
      end

      question = Question.new( :title => row["问题"],
                               :category_id => category_id,
                               :type_id => type_id,
                               :answers_attributes => answers_attributes )

      if question.save
        success += 1
      else
        failed_records << [row, question]
        Rails.logger.info("#{row} ----> #{question.errors.full_messages}")
      end

    end

    flash[:notice] = "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"
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
