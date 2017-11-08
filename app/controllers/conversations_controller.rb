class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.joins(:messages).where("messages.recipient_id = ? OR messages.sender_id = ?", current_user.id, current_user.id).distinct.order(created_at: :desc)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @complain = Complain.find(@conversation.complain_id)
    @question = @complain.question
    @quiz = Quiz.find(@complain.quiz_id)

    @newest_message = @conversation.newest_message
    @first_message = @conversation.first_message
  end
end
