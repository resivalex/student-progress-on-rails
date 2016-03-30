class SessionController < ApplicationController
  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      flash[:message] = 'Welcome!'
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:message] = 'You are wrong. Try again.'
      redirect_to root_path
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      redirect_to root_path
    else
      render_not_found
    end
  end
end