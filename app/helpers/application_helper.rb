module ApplicationHelper
  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    else
      return nil
    end
  end

  def admin?
    if current_user
      current_user.email == 'ja.lueth@gmail.com'
    end
  end

end
