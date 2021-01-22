class WelcomeController < ApplicationController
  # before_action :authenticate_user!
  before_action :initialize_cart
  #
  # def initialize
  #   # session[:cart]
  # end
  def index
    @cart = Cart.new
    @categories = Category.all
  end

  def ajax_session
    product = Product.find(params[:id])
    session[:cart][product.category.title] = product.attributes
    session[:cart][product.category.title][:quantity] = 1
    respond_to do |format|
      format.json { render json: session[:cart][product.category.title].to_json }
    end
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end
end
