class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path, notice: t("site.account.profile.update_success")
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
        profile_attributes: [:id, :nickname, :real_name, :organization, :department, :wechat, :qq, :time_zone])
  end

  def find_user
    @user = current_user
    @user.create_profile if @user.profile.nil?
    @user.create_profile unless @user.profile
  end

end
