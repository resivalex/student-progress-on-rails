class StudentsController < ApplicationController
  def index
    group_id = params[:group_id]
    if group_id
      if Group.exists? group_id
        @students = User.students_by_group group_id
      else
        render plain: 'Not found', status: :not_found
      end
    else
      @students = User.students
    end
  end

  def show
    @student = User.student_by_id params[:id]
    unless @student
      render plain: 'Not found', status: :not_found
    end
  end
end