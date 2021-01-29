class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource :order
  layout "admin"

  def index

  end

  def shipment

  end
end
