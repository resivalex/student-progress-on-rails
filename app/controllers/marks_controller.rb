class MarksController < ApplicationController
  def create
    if Mark.add params
      render plain: 'OK'
    else
      render plain: 'Bad request', status: :bad_request
    end
  end

  def index
    @marks = Mark.all.map do |m|
      OpenStruct.new m.to_api
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