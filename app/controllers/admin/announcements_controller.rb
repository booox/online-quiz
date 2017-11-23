class Admin::AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_announcement, only: [:edit, :update, :destroy]

  def index
    @announcements = Announcement.all
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)

    if @announcement.save
      redirect_to admin_announcements_path, notice: "Announcement Created Succeed."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @announcement.update(announcement_params)
      redirect_to admin_announcements_path, notice: "Announcement Updated Succeed."
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy
    redirect_to admin_announcements_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:message, :starts_at, :ends_at)
  end

  def find_announcement
    @announcement = Announcement.find(params[:id])
  end

end
