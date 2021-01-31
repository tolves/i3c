class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  def user_for_paper_trail
    if user_signed_in?
      return current_user.email
    end

    if admin_signed_in?
      current_admin.email
    end
  end

  def current_ability
    @current_ability ||= current_admin ? Ability.new(current_admin) : Ability.new(current_user)
  end

  # rescue_from StandardError do |exception|
  #   puts exception.message
  #   raise flash[:danger] = exception.message
  #   respond(:standard_error, 500, exception.message)
  # end
end