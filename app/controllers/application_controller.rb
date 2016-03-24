class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  def current_user
    User.find_by_id session[:user_id]
  end

  def require_admin
    if current_user
      unless current_user.admin?
        render plain: 'Forbidden', status: :forbidden
      end
    else
      render plain: 'Unathorized', status: :unauthorized
    end
  end

  def require_teacher
    if current_user
      unless current_user.teacher?
        render plain: 'Forbidden', status: :forbidden
      end
    else
      render plain: 'Unathorized', status: :unauthorized
    end
  end
end
