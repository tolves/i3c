class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_cart
  before_action :merge_cart, only: :show

  def show
    @cart = current_user.cart.lists
  end

  def destroy
    id = params[:format]
    list = List.find(id)
    session[:cart].delete_if do |key, value|
      value['id'] == list.product.id
    end
    current_user.cart.lists.destroy(list)
    redirect_to cart_path
  end

  private

  def create_cart
    ActiveRecord::Base.connected_to(role: :writing) { current_user.create_cart! } if current_user.cart.blank?
  end

  def merge_cart
    ActiveRecord::Base.connected_to(role: :writing) do
      session[:cart].each do |index, product|
        next if !Product.exists?(product['id'])

        if current_user.cart.lists.exists?(product_id: product['id'])
          list = current_user.cart.lists.find_by(product_id: product['id'])
          next if list.update!(quantity: product['quantity'])
        end

        current_user.cart.lists.create!(product_id: product['id'], quantity: product['quantity'])

      end
    end
  end
end
