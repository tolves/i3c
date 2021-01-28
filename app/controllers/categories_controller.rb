class CategoriesController < ApplicationController
  load_and_authorize_resource param_method: :params_category
  skip_authorization_check :only => :products
  before_action :authenticate_admin!, except: :products
  layout "admin"

  def index
  end

  def new
  end

  def create
    @category.save!
    redirect_to admin_category_path @category
  end

  def show
  end

  def edit
  end

  def update
    if @category.update!(params_category)
      redirect_to admin_category_path @category
    else render :edit
    end
  end

  def destroy
    @category.destroy

    redirect_to admin_categories_path
  end

  def meta_data
    @category = Category.find params[:category_id]
    respond_to do |format|
      format.json { render json: @category.meta_data.to_json }
    end
  end

  def products
    @category = Category.find(params[:category_id])
    @products = @category.products
  end

  private

  def params_category
    params.require(:category).permit(:title, :meta_data)
  end
end
