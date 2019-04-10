class SessionsController < ApplicationController

  def create
    reset_session
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    session[:expires_at] = Time.now + 30.minutes
    user.emailmsgnotification = nil
    user.touch
    user.save
    redirect_to offers_overview_path
  end

  def destroy
    session[:user_id] = nil
    session[:expires_at] = Time.now
    reset_session
    redirect_to root_path
  end

end
