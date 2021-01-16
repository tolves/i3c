class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @out = Admin.first
  end

  def show
    @out = Admin.first
  end
end
