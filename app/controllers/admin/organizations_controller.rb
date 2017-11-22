class Admin::OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_organization, only: [:edit, :update, :destroy]


  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
    @organization.departments.build
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to admin_organizations_path, notice: "组织添加成功"
    else
      render :new
    end
  end

  def edit
    @organization.departments.build if @organization.departments.empty?
  end

  def update
    if @organization.update(organization_params)
      redirect_to admin_organizations_path, notice: "组织更新成功"
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to admin_organizations_path
  end


  private

  def organization_params
    params.require(:organization).permit(:title, :alias,
                  :departments_attributes => [:id, :title, :alias])
  end

  def find_organization
    @organization = Organization.find(params[:id])
  end

end
