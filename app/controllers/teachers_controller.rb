class TeachersController < ApplicationController
  def index
    @teachers = User.teachers
  end

  def show
    @teacher = User.teacher_by_id params[:id]
    unless @teacher
      render_not_found
    end
  end
end