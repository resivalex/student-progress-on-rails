class LessonsController < ApplicationController
  def index
    @lessons = Lesson.to_api
  end

  def show
    @lesson = Lesson.find_by_id(params[:id]).rich_struct
    unless @lesson
      render plain: 'Not found', status: :not_found
    end
  end

  def create
    lesson = Lesson.new.from_api params
    if lesson.save
      render plain: 'OK'
    else
      render json: lesson.errors, status: :bad_request
    end
  end

  def update
    lesson = Lesson.find_by_id params[:id]
    if lesson
      lesson.from_api params
      if lesson.save
        render plain: 'OK'
      else
        render json: lesson.errors, status: :bad_request
      end
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def destroy
    lesson = Lesson.find_by_id params[:id]
    if lesson
      lesson.destroy
      render plain: 'OK'
    else
      render plain: 'Not found', status: :not_found
    end
  end
end