class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource :order
  layout "admin"

  def index
    @orders = @orders.order(updated_at: :desc)
  end

  def show

  end

  def shipment
    if params[:order]
      @order.update! params_shipment
      redirect_to admin_orders_path
    end
  end

  def history
    @histories = Product.history
  end

  private

  def params_shipment
    params[:order].permit(:courier, :tracking)
  end

end
