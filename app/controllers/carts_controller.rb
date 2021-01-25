class CartsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :create_cart, only: :show
  before_action :merge_cart, only: :show
  before_action :sync_price, only: :show
  after_action :sync_cart, only: :show

  def show
    @cart = current_user.cart
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

  def qty_change
    puts params

    list = current_user.cart.lists.find_by_product_id(params['product_id'])

    case params['method']
    when 'minus'
      if list.quantity > 1
        list.quantity -= 1
      end
    when 'plus'
      list.quantity += 1
    end
    list.save!
    respond_to do |format|
      format.json { render json: [list.quantity, list.quantity * list.price, current_user.cart.amount].to_json }
    end
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
          next if list.update!(quantity: product['quantity'], price: list.product.price)
        end

        current_user.cart.lists.create!(product_id: product['id'], quantity: product['quantity'], price: product['price'])
      end
    end
  end

  def sync_cart
    # while session[:cart][category] has product, sync the qty
    # else append list.product & list.quantity to session[:cart][category]
    current_user.cart.lists.each do |l|
      if session[:cart][l.product.category.title]
        if session[:cart][l.product.category.title]['id'] == l.product.id
          session[:cart][l.product.category.title]['quantity'] = l.quantity
        end
      else session[:cart][l.product.category.title] = l.product.attributes
      session[:cart][l.product.category.title]['quantity'] = l.quantity
      end
    end
  end

  def sync_price
    ActiveRecord::Base.connected_to(role: :writing) do
      current_user.cart.lists.each do |l|
        l.update(price: l.product.price) if l.price != l.product.price
      end
    end
  end

end
