class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = I18n.t(:welcome)
      current_user.admin? ? (redirect_to admin_root_path) : (redirect_to root_path)
    else
      flash[:danger] = I18n.t(:login_error)
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
