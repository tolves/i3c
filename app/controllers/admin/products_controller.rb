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
    @inventory = @product.inventory ? @product.inventory : @product.build_inventory
    if params[:inventory]
      @inventory.inbound params_inventory
      flash[:success] = 'You has successfully add inventory data'
      redirect_to admin_products_path
    end
  end

  def history
    @histories = Product.history
  end

  private

  def params_product
    params.require(:product).permit(:title, :category_id, :description, :band, :price, :image, :content, :meta_data => {})
  end

  def params_inventory
    params.require(:inventory).permit(:quantity, :cost, :note)
  end
end
