class InboundsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"
end
