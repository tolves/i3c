class AddressController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def create
    @address = current_user.create_address! params_address
  end

  def edit
  end

  def update
    current_user.address.update! params_address
  end

  private

  def params_address
    params[:address].permit(:full_name, :phone, :postcode, :line_1, :line_2, :town, :county, :instructions, :security_code)
  end
end
