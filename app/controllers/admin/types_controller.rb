class Admin::TypesController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_type, only: [:edit, :update, :destroy]

  def index
    @types = Type.all
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(type_params)

    if @type.save
      redirect_to admin_types_path, notice: "题型添加成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @type.update(type_params)
      redirect_to admin_types_path, notice: "题型更新成功"
    else
      render :edit
    end
  end

  def destroy
    @type.destroy
    redirect_to admin_types_path
  end

  private

  def type_params
    params.require(:type).permit(:title)
  end

  def find_type
    @type = Type.find(params[:id])
  end


end
