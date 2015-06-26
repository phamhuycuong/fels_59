class RelationshipsController < ApplicationController

  def index
    if [Settings.user.following, Settings.user.followers].include? params[:status]
      @user = User.friendly.find params[:id]
      @follows = @user.send(params[:status]).paginate page: params[:page], per_page: Settings.user.follow_paginate
      @title = t "user." + params[:status], count: @follows.count
    end
  end

  def create
    user = User.find params[:followed_id]
    current_user.follow user
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow user
    redirect_to user
  end
end
