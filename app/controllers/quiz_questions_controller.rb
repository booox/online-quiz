class QuizQuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_quiz

  def index
    @questions = @quiz.questions
  end

  def show
    @question = @quiz.questions.find(params[:id])
    @question_answers = @question.answers.order("RANDOM()")

    @right_answer = @question.answers.right_answer
    @right_answer_id = @right_answer.id
    @quiz_detail = QuizDetail.where(quiz_id: @quiz.id,
                                    user_id: current_user.id,
                                    question_id: @question.id).first
    @answered = @quiz_detail.blank? ? false : true


    if not @quiz_detail.blank?
      @is_correct = @quiz_detail.is_correct
      @choice_id = @quiz_detail.choice_id
    end


    @previous_question = @quiz.questions.where('quiz_questions.quiz_id = ? and questions.id < ?', @quiz.id, @question.id).order('id DESC').first
    @next_question = @quiz.questions.where('quiz_questions.quiz_id = ? and questions.id > ?', @quiz.id, @question.id).order('id ASC').first

  end

  def create_detail

    @right_answer = Answer.where(question_id: params[:id],
                                is_right: true).first
    @right_answer_id = @right_answer.id
    @choice_id = params[:choice_id].to_i
    is_correct = (@right_answer_id == @choice_id) ? true : false

    @quiz_detail = QuizDetail.where(quiz_id: params[:quiz_id],
                                    user_id: current_user.id,
                                    question_id: params[:id]).first

    if @quiz_detail.blank?
      QuizDetail.create!(user_id: current_user.id,
                        quiz_id: params[:quiz_id],
                        question_id: params[:id],
                        choice_id: @choice_id,
                        is_correct: is_correct)
    end
  end


  private

  def find_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

end
