class UsersController < ApplicationController
  before_filter :require_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id params[:id]
    unless @user
      render_not_found
    end
  end

  def create
    user = User.new.from_api params
    if user.save
      render nothing: true
    else
      render_bad_request user.errors
    end
  end

  def update
    @user = User.find_by_id params[:id]
    if @user
      @user.from_api params
      if @user.save
        render nothing: true
      else
        render_bad_request @user.errors
      end
    else
      render_not_found
    end
  end

  def destroy
    user = User.find_by_id params[:id]
    if user
      user.destroy
      render nothing: true
    else
      render_not_found
    end
  end

private

  def user_params
  end
end
