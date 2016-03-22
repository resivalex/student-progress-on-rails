class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  def current_user
    User.find_by_id session[:user_id]
  end

  def admin_user?
    current_user && current_user.admin?
  end

  def teacher_user?
    current_user && current_user.teacher?
  end

  def chief_user?
    current_user && current_user.chief?
  end

  def student_user?
    current_user && current_user.student?
  end
end
