class WelcomeController < ApplicationController
  # before_action :authenticate_user!
  skip_authorization_check
  before_action :initialize_cart

  def index
    @categories = Category.all
    @amount = cart_amount
  end

  def selected
    @product = Product.find params[:format]
    session[:cart][@product.category.title] = @product.attributes
    session[:cart][@product.category.title]['quantity'] = 1
    @amount = cart_amount
  end

  def qty_change
    puts params
    product = Product.find(params['product_id'])
    case params['method']
    when 'minus'
      if session[:cart][product.category.title]['quantity'] > 1
        session[:cart][product.category.title]['quantity'] -= 1
      end
    when 'plus'
      if session[:cart][product.category.title]['quantity'] < product.inventory.quantity
        session[:cart][product.category.title]['quantity'] += 1
      end
    end
    respond_to do |format|
      format.json { render json: [session[:cart][product.category.title]['quantity'], cart_amount].to_json }
    end
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end

  def cart_amount
    session[:cart].sum do |index, product|
      product['price'] * product['quantity']
    end
  end
end
