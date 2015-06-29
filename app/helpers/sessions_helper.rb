module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def check_login
    redirect_to login_path unless logged_in?
  end

  def check_login_admin
    unless logged_in?
      redirect_to login_path
    else
      redirect_to root_path unless current_user.admin?
    end
  end
end
