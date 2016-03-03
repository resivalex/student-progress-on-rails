class AdminController < ApplicationController
  before_action :check_permissions

  def index
  end

private

  def admin?
    user_id = cookies[:user_id]
    return false if not user_id
    user = User.where(id: user_id).take
    return false if not user
    return user.admin?
  end

  def check_permissions
    if not admin?
      flash[:message] = 'You aren\'t admin'
      redirect_to '/'
    end
  end
end