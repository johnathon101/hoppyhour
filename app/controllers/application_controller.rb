class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    else
      return nil
    end
  end

  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end

  def admin?
    if current_user.email == 'ja.lueth@gmail.com'
        return true
    else
        return false
    end
  end

  def clear_session
    session[:brewdb_id] = nil
    session[:beer_name] = nil
    session[:brew_id] = nil
  end
  def logout
    session[:user_id] = nil
  end
end
