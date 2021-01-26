class AccountController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user
  def show

  end
end
