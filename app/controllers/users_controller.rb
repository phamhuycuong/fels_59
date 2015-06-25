class UsersController < ApplicationController
  before_action :set_user, except: [:show, :new, :index, :create]
  before_action :check_login, except: [:new, :create]

  def index
    if params[:status].present?
      @user  = User.friendly.find params[:id]
      @follows = @user.send(params[:status]).paginate page: params[:page]
      @title = t "user." + params[:status], count: @follows.count
      render "show_follow"
    else
      @users = User.all
    end
  end

  def show
    @user = User.friendly.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = I18n.t :welcome
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = I18n.t "user.update_success"
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = I18n.t "user.destroy_success"
    redirect_to users_path
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
