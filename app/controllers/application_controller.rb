class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include RenderHelper;

  def current_user
    User.find_by_id session[:user_id]
  end

  def require_admin
    if current_user
      unless current_user.admin?
        render_forbidden
      end
    else
      render_unathorized
    end
  end

  def require_teacher
    if current_user
      unless current_user.teacher?
        render_forbidden
      end
    else
      render_unathorized
    end
  end
end
