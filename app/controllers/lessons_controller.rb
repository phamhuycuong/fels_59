class LessonsController < ApplicationController
  def index
    @lessons = current_user.lessons
  end

  def show
    @category = Category.find params[:category_id]
    @lesson = Lesson.find params[:id]
  end

  def create
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build user: current_user
    if @lesson.save
      flash[:success] = I18n.t "lesson.start_learn"
      redirect_to edit_category_lesson_path @category, @lesson
    else
      flash[:danger] = I18n.t "danger.not_enought_word"
      redirect_to :back
    end
  end

  def edit
    @category = Category.find params[:category_id]
    @lesson = Lesson.find params[:id]
  end

  def update
    @category = Category.find params[:category_id]
    @lesson = Lesson.find params[:id]
    if @lesson.update lesson_params
      flash[:success] = I18n.t :word_success_updated
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = I18n.t "lesson.error_input"
      render "edit"
    end
  end

  def destroy
    @lesson = Lesson.find params[:id]
    @user = @lesson.user

    if @lesson.destroy
      flash[:success] = I18n.t "lesson.destroy_success"
    else
      flash[:success] = I18n.t "lesson.destroy_error"
    end

    redirect_to @user
  end

  private
  def lesson_params
    params.require(:lesson).permit lesson_words_attributes: [:id, :word_id, :answer_id]
  end
end
