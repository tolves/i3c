class AdminController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource :admin
  layout "admin"

  def show
  end
end
