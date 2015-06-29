class Admin::DashbroadsController < ApplicationController
  before_action :check_login_admin

  def home
  end
end
