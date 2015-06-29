class Admin::UsersController < ApplicationController
  before_action :set_user, except: [:new, :index, :create]
  before_action :check_login_admin

  def index
    @users = User.paginate page: params[:page], per_page: Settings.user.user_paginate
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = I18n.t "user.update_success"
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = I18n.t "user.destroy_success"
    else
      flash[:danger] = I18n.t "user.destroy_error"
    end

    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.friendly.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
