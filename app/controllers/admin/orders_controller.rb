include PayPalCheckoutSdk::Orders

class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource :order
  layout "admin"

  def index
    @orders = @orders.order(updated_at: :desc)
  end

  def show
    request = PaypalShipping::OrderGetShipping::new(@order.paypal.transaction_id, @order.tracking)
    begin
      @response = PaypalClient::client.execute(request)
    rescue => e
      puts e.result
      flash[:danger] = e.result
    end
  end

  def shipment
    if params[:order]
      if send_shipment_to_paypal.status_code == 200
        @order.update! params_shipment
      end
      redirect_to admin_orders_path
    end
  end

  def paypal
    @request = OrdersGetRequest::new(@order.paypal.orderID)
    begin
      @response = PaypalClient::client.execute(@request)
    rescue => e
      puts e.result
      flash[:danger] = e.result
    end
    render partial: 'admin/orders/paypal'
  end

  def history
    @histories = Product.history
  end

  private

  def params_shipment
    params[:order].permit(:courier, :tracking)
  end

  def send_shipment_to_paypal
    # send shipment info to paypal
    request = PaypalShipping::OrderUpdateShipping::new
    request.request_body({ trackers: [{ transaction_id: "#{@order.paypal.transaction_id}", tracking_number: "#{params_shipment[:tracking]}", status: "SHIPPED", carrier: "#{params_shipment[:courier]}" }] })

    begin
      response = PaypalClient::client.execute(request)
    rescue => e
      puts e.result
      flash[:danger] = e.result
    end
    puts response
    response
  end
end
