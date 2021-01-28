class ProductsController < ApplicationController
  load_and_authorize_resource :product
  def show
  end
end
