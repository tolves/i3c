class WelcomeController < ApplicationController
  # before_action :authenticate_user!
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
