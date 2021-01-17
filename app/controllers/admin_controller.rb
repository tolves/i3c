class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"
  def index
    @out = Admin.first
  end

  def show
    @out = Admin.first
  end
end
