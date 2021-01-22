class AddressController < ApplicationController
  def create
    @address = current_user.build_address params_address
    @address.save!
  end

  private

  def params_address
    params[:address].permit(:full_name, :phone, :postcode, :line_1, :line_2, :line_3, :town, :county, :instructions, :security_code)
  end
end
