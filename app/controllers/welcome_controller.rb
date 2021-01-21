class WelcomeController < ApplicationController
  # before_action :authenticate_user!
  def index
    @cart = Cart.new
    @categories = Category.all
  end

  def ajax_session
    product = Product.find(params[:id])
    session[:cart] ||= []
    session[:cart].append product
    respond_to do |format|
      format.json { render json: product.to_json }
    end
  end
end
