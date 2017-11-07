class ComplainsController < ApplicationController
  before_action :authenticate_user!

  def new

  end

  def create
    @complain = Complain.new(complain_params)
    @complain.user = current_user

    if @complain.save
    #   redirect_to :back, notice: "吐槽成功"
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def complain_params
    params.require(:complain).permit(:content, :question_id)
  end

end
