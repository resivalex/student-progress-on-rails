class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    id = params[:id]
    if User.exists? id
      @user = User.find id
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def create
    @user = User.new.from_api params
    if @user.save
      render plain: 'OK'
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def update
    id = params[:id]
    if User.exists? id
      @user = User.find(id).from_api params
      if @user.save
        render plain: 'OK'
      else
        render json: @user.errors, status: :bad_request
      end
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def destroy
    id = params[:id]
    if User.exists? id
      User.find(id).destroy
      render plain: 'OK'
    else
      render plain: 'Not found', status: :not_found
    end
  end

private

  def user_params
  end
end
