class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_user, only: [:edit, :update, :destroy, :password, :password_update]

  def index
    @q = User.where(is_admin: false).ransack(params[:q])
    @users = @q.result.includes(:profile).order("id DESC").paginate( :page => params[:page], per_page: 35 )
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: t("site.admin.users.create_success")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t("site.admin.users.update_success")
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    Leaderboard.prefixs.each do |prefix|
      keys = Leaderboard.get_keys_begin_with("#{prefix}:quiz:")
      keys.each do |key|
        Leaderboard.remove_element(key, "user:#{@user.id}")
      end
    end

    flash[:warning] = t("site.admin.users.delete_success")
    redirect_to admin_users_path
  end

  def password
  end

  def password_update
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.update(user_params)
      redirect_to admin_users_path, notice: t("site.admin.users.update_user_password_success")
    else
      render :password
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
            profile_attributes: [:id, :nickname, :real_name, :organization, :department, :wechat, :qq])
  end

  def find_user
    @user = User.find(params[:id])
  end

end
