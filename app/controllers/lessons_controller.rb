class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def create
    lesson = Lesson.new.from_api
    if lesson.save
      render plain: 'OK'
    else
      render plain: 'Bad request', status: :bad_request
    end
  end
end