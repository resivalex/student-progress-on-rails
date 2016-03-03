class TablesController < ApplicationController
  def admin?
    user_id = cookies[:user_id]
    return false if not user_id
    user = User.where(id: user_id).take
    return false if not user
    return user.admin?
  end

  def index
    if not admin?
      redirect_to '/'
    else
      @mark_tracks = MarkTrack.all
    end
  end
end