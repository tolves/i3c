class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def new
    if current_user.cart.lists.empty?
      flash[:warning] = 'add products to cart before checkout'
      redirect_to root_path
    end
  end

  def create
    if current_user.address.blank?
      flash[:warning] = 'address shoule not be empty'
      return render :new
    end

    @order = Order.new
    @order.user = current_user
    @order.status = :unpaid
    @order.amount = current_user.cart.amount
    address = { full_name: current_user.address.full_name, phone: current_user.address.phone, postcode: current_user.address.postcode, line_1: current_user.address.line_1, line_2: current_user.address.line_2, line_3: current_user.address.line_3, town: current_user.address.town, county: current_user.address.county, instructions: current_user.address.instructions, security_code: current_user.address.security_code }
    if @order.save!
      current_user.cart.lists.each do |l|
        @order.lists.create!(product_id: l.product.id, quantity: l.quantity, price: l.price)
        l.destroy!
      end
      @order.create_address! address
      session[:cart]
      redirect_to account_orders_path
    end
    # request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    # request.request_body({
    #                        intent: "CAPTURE",
    #                        purchase_units: [
    #                          {
    #                            amount: {
    #                              currency_code: "USD",
    #                              value: "100.00"
    #                            }
    #                          }
    #                        ]
    #                      })
    #
    # begin
    #   # Call API with your client and get a response for your call
    #   response = PaypalClient.client.execute(request)
    #
    #   # If call returns body in response, you can get the deserialized version from the result attribute of the response
    #   order = response.result
    #   puts order
    # rescue PayPalHttp::HttpError => ioe
    #   # Something went wrong server-side
    #   puts ioe.status_code
    #   puts ioe.headers["debug_id"]
    # end
  end

  private

  def params_order
    params[:order].permit(:address, :user, :status)
  end
end
