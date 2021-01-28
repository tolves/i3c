class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource :order

  def index
  end
end
