class QuizQuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_quiz

  def index
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_type = @quiz.quiz_type
    @questions = @quiz.questions

    @answer_correct_questions_ids = @quiz.quiz_details.where(is_correct: true, user_id: current_user).pluck(:question_id)
    @answer_wrong_questions_ids = @quiz.quiz_details.where(is_correct: false, user_id: current_user).pluck(:question_id)
  end

  def show

    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:id])
    @quiz_type = @quiz.quiz_type

    @user_feeling = Feeling.where(user_id: current_user.id, question_id: @question.id).first.try(:value)
    @complain = Complain.new

    @question_answers = @question.answers.order("RANDOM()")

    @quiz_correct_answers_count = QuizDetail.quiz_correct_answers(@quiz, current_user).size
    @quiz_wrong_answers_count = QuizDetail.quiz_wrong_answers(@quiz, current_user).size
    @quiz_answered_question_count = QuizDetail.quiz_answered_question(@quiz, current_user).size

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
    @question = @quiz.questions.find(params[:id])
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

      user_quiz = current_user.get_user_quiz("wrong")  # for wrongs
      if ! user_quiz.questions.include?(@question)
        user_quiz.questions << @question
      end
    end
  end


  def favorite
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:id])
    @not_favorite = current_user && ! current_user.favorite_question?(@question)
    @is_favorite = current_user && current_user.favorite_question?(@question)

    user_quiz = current_user.get_user_quiz("favorite")  # for favorite

    if @not_favorite
      current_user.favorite_questions << @question
      user_quiz.questions << @question  # for favorite
    elsif @is_favorite
      current_user.favorite_questions.delete(@question)
      user_quiz.questions.delete(@question)  # for favorite

      # quiz_detail = QuizDetail.where(quiz_id: user_quiz.id,
      #                 user_id: current_user.id,
      #                 question_id: @question.id).first
    end
  end

  def feeling
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:id])
    @feeling_value = params[:feeling_value]

    feeling = @question.find_feeling(current_user)

    if feeling
      feeling.update(value: @feeling_value)
    else
      Feeling.create(user_id: current_user.id, question_id: @question.id, value: @feeling_value)
    end
  end

  def complain
    complain = Complain.create(user: current_user,
                              question_id: params[:complain][:question_id],
                              quiz_id: params[:complain][:quiz_id],
                              content: params[:complain][:content])
    if complain.save

      notification_message = "有新的吐槽反馈，请到<吐槽管理>中处理."
      admin = User.where(is_admin: true).first
      Notification.send_notification(admin, "吐槽反馈", notification_message)

      respond_to do |format|
        format.js
      end
    end
  end

  private

  def find_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

end
