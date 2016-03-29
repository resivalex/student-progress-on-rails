class SessionController < ApplicationController
  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      flash[:message] = 'Welcome!'
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:message] = 'You are wrong. Try again.'
      render nothing: true
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      redirect_to '/'
    else
      render plain: 'Not found', status: :not_found
    end
  end
end