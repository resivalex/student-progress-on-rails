class TablesController < ApplicationController
  def index
    user_id = cookies[:user_id]
    if user_id
      user = User.where(id: user_id).take

      if user && user.admin?
        redirect_to '/'
      end
    end
  end
end