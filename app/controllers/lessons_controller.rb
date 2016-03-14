class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def show
    id = params[:id]
    if Lesson.exists? id
      @lesson = Lesson.find id
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def create
    lesson = Lesson.new.from_api params
    if lesson.save
      render plain: 'OK'
    else
      render plain: 'Bad request', status: :bad_request
    end
  end

  def update
    id = params[:id]
    if Lesson.exists? id
      lesson = Lesson.find id
      lesson.from_api params
      if lesson.save
        render plain: 'OK'
      else
        render plain: 'Bad request', status: :bad_request
      end
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def destroy
    id = params[:id]
    if Lesson.exists? id
      Lesson.find(id).destroy
      render plain: 'OK'
    else
      render plain: 'Not found'
    end
  end
end