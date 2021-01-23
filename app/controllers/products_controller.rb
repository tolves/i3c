class ProductsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new params_product
    @product.save!
    redirect_to admin_product_path @product
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update!(params_product)
      redirect_to admin_product_path(@product)
    else render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to admin_products_path
  end

  private

  def params_product
    params.require(:product).permit(:title, :category_id, :description, :band, :price, :image, :content, :meta_data => {})
  end
end
