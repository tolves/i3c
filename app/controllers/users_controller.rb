class UsersController < ApplicationController
  before_action :authenticate_admin!
  layout :admin_or_user

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id]) || current_user
  end

  def new
    # @user = User.new
  end

  def create
    # @user = User.new params_users
    # @user.save!
    # redirect_to user_path
  end

  def update
    @user = User.find params[:id]
    if @user.update!(params_user)
      redirect_to @user
    else render :edit
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  private

  def params_user
    # params.require(:user).permit(:title, :meta_data)
  end
end
