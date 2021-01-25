include PayPalCheckoutSdk::Orders

class PaymentController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :order
  # skip_before_action :verify_authenticity_token, :only => [:create_paypal_transaction]

  def new
    @order = Order.find(params[:order_id])
  end

  def create
    data = JSON.parse params['data']
    details = JSON.parse params['details']
    puts data['orderID']

    order = Order.find(params[:order_id])
    order.build_paypal(p_orderId: data['orderID'], p_data: data, p_details: details)
    order.paypal.save!

    order.status = :paid
    order.save!
    flash[:success] = 'Congratulations, You have paid successfully. We will dispatch your order after 4 hours'
    redirect_to account_order_path(order)

  end
end