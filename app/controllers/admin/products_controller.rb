class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource :product, param_method: :params_product
  layout "admin"

  def index
    @products = @products.order(updated_at: :desc)
  end

  def new
  end

  def create
    @product.save!
    redirect_to admin_product_path @product
  end

  def show
  end

  def edit
  end

  def update
    if @product.update!(params_product)
      redirect_to admin_product_path(@product)
    else render :edit
    end
  end

  def destroy
    @product.destroy

    redirect_to admin_products_path
  end

  def inbound
    @inbound = @product.inbound ? @product.inbound : @product.build_inbound
    if params[:inbound]
      ActiveRecord::Base.connected_to(role: :writing) do
        @inbound.update! params_inbound
      end
      flash[:success] = 'You has successfully add inbound data'
      redirect_to admin_products_path
    end
  end

  private

  def params_product
    params.require(:product).permit(:title, :category_id, :description, :band, :price, :image, :content, :meta_data => {})
  end

  def params_inbound
    params.require(:inbound).permit(:quantity, :cost, :note)
  end
end
