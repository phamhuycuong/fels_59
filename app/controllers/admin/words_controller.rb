class Admin::WordsController < ApplicationController
  before_action :set_word, except: [:new, :index, :create]
  before_action :check_login_admin

  def index
    @words = Word.paginate page: params[:page], per_page: Settings.words_paginate
  end

  def show
  end

  def new
    @word = Word.new
    @count_answer = 0
    Settings.word.max_answer.times{@word.answers.build}
  end

  def edit
    @count_answer = @word.answers.count
    (Settings.word.max_answer - @count_answer).times{@word.answers.build}
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = I18n.t :word_success_created
      redirect_to admin_word_path @word
    else
      render "new"
    end
  end

  def update
    if @word.update word_params
      flash[:success] = I18n.t :word_success_updated
      redirect_to admin_word_path @word
    else
      render "edit"
    end
  end

  def destroy
    @word.destroy
    flash[:success] = I18n.t :word_success_destroy
    redirect_to admin_words_path
  end

  private
  def set_word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:word).permit :content, :category_id, answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
