class Admins::UsersController < ApplicationController
  before_action :authenticate_user!
  layout "admin"

  def index
    @users = User.all
  end

  def show
    current_user
  end
end
