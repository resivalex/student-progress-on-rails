class MarksController < ApplicationController
  def create
    if Mark.add params
      render plain: 'OK'
    else
      render plain: 'Bad request', status: :bad_request
    end
  end
end