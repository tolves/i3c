include PayPalCheckoutSdk::Orders

class PaymentController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :order
  skip_before_action :verify_authenticity_token, :only => [:create_transaction, :create]

  def new
  end

  def create
    data = params['data']
    request = OrdersCaptureRequest::new(data['orderID'])
    request.prefer("return=representation")

    begin
      response = PaypalClient::client.execute(request)
    rescue => e
      puts e.result
    end

    response = PaypalClient::openstruct_to_hash(response)
    result = response[:result]

    if response[:status_code] == 201 && result[:status] == 'COMPLETED'
      @order.create_paypal!(orderID: result[:id], data: data, response: response, payer: result[:payer], items: result[:purchase_units][0][:items])
      @order.status = :paid
      @order.save!
    end
    flash[:success] = 'Congratulations, You have paid successfully. We will dispatch your order after 4 hours'
    respond_to do |format|
      format.html { render json: response.to_json }
    end
  end

  def create_transaction
    request = OrdersCreateRequest::new
    request.prefer("return=representation")
    request.request_body(body_build)
    response = PaypalClient::client.execute(request)
    respond_to do |format|
      format.json { render json: response.result.id.to_json }
    end
  end

  private

  def body_build
    { intent: 'CAPTURE', purchase_units: [{ description: 'PC Components', custom_id: @order.id, amount: { currency_code: 'EUR', value: @order.amount, breakdown: { item_total: { currency_code: 'EUR', value: @order.amount }, shipping: { currency_code: 'EUR', value: '0.00' } } }, items: @order.lists.map { |l| { name: l.product.title, unit_amount: { currency_code: 'EUR', value: l.price }, quantity: l.quantity } }, shipping: { method: 'An Post', address: { name: { full_name: @order.address.full_name }, address_line_1: @order.address.line_1, address_line_2: @order.address.line_2, admin_area_2: @order.address.town, admin_area_1: @order.address.county, postal_code: @order.address.postcode, country_code: 'IE' } } }] }
  end
end