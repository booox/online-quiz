class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path, notice: "个人资料修改成功"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
        profile_attributes: [:id, :nickname, :real_name, :organization, :department, :wechat, :qq])
  end

  def find_user
    @user = current_user
    @user.create_profile if @user.profile.nil?
    @user.create_profile unless @user.profile
  end

end
