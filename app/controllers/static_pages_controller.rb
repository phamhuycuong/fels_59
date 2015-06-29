class StaticPagesController < ApplicationController
  before_action :check_login

  def home
    @user = current_user
  end
end
