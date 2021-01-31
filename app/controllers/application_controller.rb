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

  rescue_from StandardError do |exception|
    puts exception.message
    flash[:danger] = exception.message
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to(root_path) }
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end
end