class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  layout :admin_or_user

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new params_category
    @category.save!
    redirect_to category_path @category
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit

  end

  def update

  end

  def meta_data
    category = Category.find params[:category_id]
    respond_to do |format|
      format.json { render json: category.meta_data.to_json }
    end
  end

  private

  def params_category
    params.require(:category).permit(:title, :meta_data)
  end
end
