class UsersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource # param_method: :params_category
  layout "admin"

  def index
  end

  def show
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
    if @user.update!(params_user)
      redirect_to admin_user_path @user
    else render :edit
    end
  end

  def edit
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path
  end

  def history
    @histories = Product.history
  end

  private

  def params_user
    # params.require(:user).permit(:title, :meta_data)
  end
end
