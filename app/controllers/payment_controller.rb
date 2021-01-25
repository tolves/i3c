class PaymentController < ApplicationController
  load_and_authorize_resource :order

  def new
    puts params
    order_id = params[:order_id]
    @order = Order.find(params[:order_id])
  end
end
