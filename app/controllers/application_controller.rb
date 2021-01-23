class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  def user_for_paper_trail
    if user_signed_in?
      return current_user
    end

    if admin_signed_in?
      current_admin.id
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to :root, notice: exception.message }
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end

  # rescue_from StandardError do |exception|
  #   flash.notice exception.message
  #   # respond_to do |format|
  #   #   format.json { head :forbidden, content_type: 'text/html' }
  #   #   format.html { redirect_to :root, notice: exception.message }
  #   #   format.js { head :forbidden, content_type: 'text/html' }
  #   # end
  # end
end