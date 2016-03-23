class SessionController < ApplicationController
  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      flash[:message] = 'Success!'
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:message] = 'You are wrong. Try again.'
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      render plain: 'OK'
    else
      render plain: 'Not found', status: :not_found
    end
  end
end