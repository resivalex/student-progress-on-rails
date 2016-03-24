class MarksController < ApplicationController
  before_filter :require_teacher, only: [:create, :show, :tracks]

  def create
    if Mark.add params
      render plain: 'OK'
    else
      render plain: 'Bad request', status: :bad_request
    end
  end

  def show
    mark = Mark.find_by_id params[:id]
    if mark
      @mark = OpenStruct.new mark.to_api
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