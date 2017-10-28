class QuizQuestionsController < ApplicationController
  before_action :authenticate_user!
  # before_action :find_quiz

  def index
    @quiz = Quiz.find(params[:quiz_id])
    @questions = @quiz.questions

    @answer_correct_questions_ids = @quiz.quiz_details.where(is_correct: true, user_id: current_user).pluck(:question_id)
    @answer_wrong_questions_ids = @quiz.quiz_details.where(is_correct: false, user_id: current_user).pluck(:question_id)
  end

  def show

    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:id])
    @quiz_type = @quiz.quiz_type

    @question_answers = @question.answers.order("RANDOM()")

    @correct_answers_count = QuizDetail.correct_answers(@quiz, current_user).size
    @wrong_answers_count = QuizDetail.wrong_answers(@quiz, current_user).size
    @answered_question_count = QuizDetail.answered_question(@quiz, current_user).size

    @right_answer = @question.answers.right_answer.first
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

    @not_favorite = current_user && ! current_user.favorite_question?(@question)
    @is_favorite = current_user && current_user.favorite_question?(@question)

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


  def favorite
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:id])
    @not_favorite = current_user && ! current_user.favorite_question?(@question)
    @is_favorite = current_user && current_user.favorite_question?(@question)

    # quiz = Quiz.where(title: )
    user_quiz = current_user.get_user_quiz("favorite")  # for favorite

    if @not_favorite
      current_user.favorite_questions << @question
      user_quiz.questions << @question  # for favorite
    elsif @is_favorite
      current_user.favorite_questions.delete(@question)
      user_quiz.questions.delete(@question)  # for favorite

      quiz_detail = QuizDetail.where(quiz_id: user_quiz.id,
                      user_id: current_user.id,
                      question_id: @question.id).first
      if quiz_detail
        puts "quiz_detail exist.."
        quiz_detail.destroy
      else
        puts "quiz_detail doesnot exist..."
      end


    end
  end


  private

  # def find_quiz
  #   @quiz = Quiz.find(params[:quiz_id])
  # end

end
