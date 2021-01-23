class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new params_order
  end

  private

  def params_order
    params[:order].permit(:address, :user, :status)
  end
end
