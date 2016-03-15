class MarksController < ApplicationController
  def create
    if Mark.add params
      render plain: 'OK'
    else
      render plain: 'Bad request', status: :bad_request
    end
  end

  def index
    teacher_id = params[:teacher_id]
    if teacher_id
      if User.exists? teacher_id
        teacher = User.find teacher_id
        @marks = teacher.lessons.map(&:marks).flatten
      else
        render plain: 'Not found', status: :not_found
      end
    else
      @marks = Mark.all.map do |m|
        OpenStruct.new m.to_api
      end
    end
  end

  def show
    id = params[:id]
    if Mark.exists? id
      @mark = OpenStruct.new Mark.find(id).to_api
    else
      render plain: 'Not found', status: :not_found
    end
  end

  def tracks
    id = params[:id]
    @tracks = MarkTrack.by_mark_id(id).map do |t|
      OpenStruct.new t.to_api
    end
  end
end