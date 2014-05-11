class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, notice: "Logged in!"
    else
      render :new, notice: "Email or password was invalid"
    end
  end

  def destroy
    clear_session
    logout
    redirect_to root_url, notice: "Logged out!"
  end
end
