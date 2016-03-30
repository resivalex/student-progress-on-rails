class LessonsController < ApplicationController
  before_filter :require_admin, only: [:create, :update, :destroy]

  def index
    @lessons = Lesson.to_api
  end

  def show
    @lesson = Lesson.find_by_id(params[:id]).rich_struct
    unless @lesson
      render_not_found
    end
  end

  def create
    lesson = Lesson.new.from_api params
    if lesson.save
      render nothing: true
    else
      render_bad_request lesson.errors
    end
  end

  def update
    lesson = Lesson.find_by_id params[:id]
    if lesson
      lesson.from_api params
      if lesson.save
        render nothing: true
      else
        render_bad_request lesson.errors
      end
    else
      render_not_found
    end
  end

  def destroy
    lesson = Lesson.find_by_id params[:id]
    if lesson
      lesson.destroy
      render nothing: true
    else
      render_not_found
    end
  end
end