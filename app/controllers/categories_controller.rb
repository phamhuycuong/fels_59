class CategoriesController < ApplicationController
  before_action :set_category, except: [:new, :index, :create]
  before_action :check_login

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.categories_paginate
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new category_params
    if  @category.save
      flash[:success] = I18n.t :category_success_created
      redirect_to categories_path
    else
      render "new"
    end
  end

  def update
    if @category.update category_params
      flash[:success] = I18n.t :category_success_updated
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:success] = I18n.t :category_success_destroy
    redirect_to categories_path
  end

  private
  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :title
  end
end
