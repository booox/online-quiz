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

    # @message = @conversation.messages.build

    # cookies.permanent[:"conversation-#{@conversation.id}"] = @conversation.id
  end

  def reply
    @conversation = Conversation.find(params[:id])
    first_message = @conversation.first_message

    recipient_id = first_message.recipient_id == current_user.id ? first_message.sender_id : first_message.recipient_id
    message = @conversation.messages.create(sender_id: current_user.id,
                                            recipient_id: recipient_id,
                                            subject: "回复",
                                            content: params[:message][:content])
    if message.save
      notification_user = User.find(recipient_id)
      notification_subject = "新的回复"
      notification_message = "您有新的回复，请到收件箱中查看。"
      Notification.send_notification(notification_user, notification_subject, notification_message)
      
    end
  end
end
