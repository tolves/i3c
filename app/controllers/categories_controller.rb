class CategoriesController < ApplicationController
  before_action :authenticate_admin!, except: [:ajax_products, :products]
  layout "admin"

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new params_category
    @category.save!
    redirect_to admin_category_path @category
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update!(params_category)
      redirect_to admin_category_path @category
    else render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to admin_categories_path
  end

  def meta_data
    @category = Category.find params[:category_id]
    respond_to do |format|
      format.json { render json: @category.meta_data.to_json }
    end
  end

  def ajax_products
    @category = Category.find(params[:category_id])
    respond_to do |format|
      format.json { render json: @category.products.to_json }
    end
  end

  def products
    category = Category.find(params[:category_id])
    @products = category.products
  end

  private

  def params_category
    params.require(:category).permit(:title, :meta_data)
  end
end
