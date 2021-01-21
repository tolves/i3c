class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_cart

  def new

  end

  def show
    session[:cart].each do |index, product|
      next if !Product.exists?(product['id']) || current_user.cart.lists.exists?(product_id: product['id'])

      ActiveRecord::Base.connected_to(role: :writing) do
        current_user.cart.lists.create!(product_id: product['id'], quantity: 1)
      end
    end
    @cart = current_user.cart.lists
  end

  private

  def create_cart
    ActiveRecord::Base.connected_to(role: :writing) { current_user.create_cart! } if current_user.cart.blank?
  end
end
