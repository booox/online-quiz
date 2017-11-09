class Admin::ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @conversations = Conversation.all
  end

  def show
    @conversation = Conversation.find(params[:id])
  end

  def new
    @conversation = Conversation.new
    @conversation.messages.build

    complain_id = params[:complain_id]
    if complain_id.present?
      @complain = Complain.find(complain_id)
    end
  end

  def create
    @conversation = Conversation.new(conversation_params)
    # @conversation.messages.build
    # puts "complain_id: #{params[:conversation][:complain_id]}"
    complain_id = params[:conversation][:complain_id]

    if @conversation.save!
      # redirect_to :back
      complain = Complain.find(complain_id)
      complain.update(is_replied: true)
      redirect_to admin_complains_path, notice: " 吐槽回复成功"

      notification_user = complain.user
      notification_subject = "吐槽反馈"
      notification_message = "您的吐槽，管理员已有回复，请到收件箱中查看。"
      Notification.send_notification(notification_user, notification_subject, notification_message)

    else
      render :new
    end
  end

  def edit
    @conversation = Conversation.find(params[:id])
    @conversation.messages.build if @conversation.messages.empty?
  end

  def update
    @conversation = Conversation.find(params[:id])

    if @conversation.update(conversation_params)
      redirect_to admin_conversations_path, notice: "会话更新成功"
    else
      render :edit
    end
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy
    redirect_to admin_conversations_path
  end


  private

  def conversation_params
    params.require(:conversation).permit( :complain_id,
            messages_attributes: [:sender_id, :recipient_id, :subject, :content, :conversation_id])
  end
end
