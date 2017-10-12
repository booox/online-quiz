class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end


  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "类别添加成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "类别更新成功"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def find_category
    @category = Category.find(params[:id])
    # @category = Category.find_by_uuid(params[:id])
  end

end
