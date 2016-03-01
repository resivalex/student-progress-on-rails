class LoginController < ApplicationController
  def index
    user = User.where(login: params[:login]).take
    if user && user.password == params[:password]
      flash[:message] = 'Success!'
      redirect_to '/'
    else
      flash[:message] = 'You are wrong. Try again.'
    end
  end
end