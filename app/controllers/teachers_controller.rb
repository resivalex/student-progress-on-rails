class TeachersController < ApplicationController
  def index
    @teachers = User.teachers
  end

  def show
    @teacher = User.teacher_by_id params[:id]
    unless @teacher
      render plain: 'Not found', status: :not_found
    end
  end
end