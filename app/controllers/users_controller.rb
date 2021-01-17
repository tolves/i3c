class UsersController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
    @users = User.all
  end

  def show
    current_user
  end
end
