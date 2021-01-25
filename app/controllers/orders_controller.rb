class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource # param_method: :params_order

  def index
    @orders = current_user.orders
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
        session[:cart].delete_if do |key, value|
          value['id'] == l.product.id
        end
        l.destroy!
      end
      @order.create_address! address
      redirect_to new_account_order_payment_path(@order)
    else render :new
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

  def show
    @order = Order.find(params[:id])
    puts can? :read, @order
  end

  private

  def params_order
    params[:order].permit()
  end

  def check_buyer_identity
    @order = Order.find_by_id(params[:id])
    if current_user.id != @order.buyer_id
      flash[:danger] = "Unathorized access"
      redirect_to items_path
    end
  end
end
