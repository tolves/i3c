class OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout :admin_or_user
end
