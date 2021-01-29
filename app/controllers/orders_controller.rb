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

    if @order.save!
      save_cart_lists @order
      @order.create_address! user_address
      redirect_to new_account_order_payment_path(@order)
    else render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    puts can? :read, @order
  end

  private

  def params_order
    params[:order].permit()
  end

  def user_address
    { full_name: current_user.address.full_name, phone: current_user.address.phone, postcode: current_user.address.postcode, line_1: current_user.address.line_1, line_2: current_user.address.line_2, town: current_user.address.town, county: current_user.address.county, instructions: current_user.address.instructions, security_code: current_user.address.security_code }
  end

  def save_cart_lists(order)
    current_user.cart.lists.each do |l|
      order.lists.create!(product_id: l.product.id, quantity: l.quantity, price: l.price)
      l.product.inventory.outbound l.quantity
      session[:cart].delete_if do |key, value|
        value['id'] == l.product.id
      end
      l.destroy!
    end
  end
end
