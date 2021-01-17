class ProductsController < ApplicationController
  before_action :authenticate_admin!
  layout :admin_or_user

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new params_product
    @product.save!
    redirect_to product_path @product
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def params_product
    params.require(:product).permit(:title, :category_id, :description, :band, :price, :meta_data => {})
  end
end
