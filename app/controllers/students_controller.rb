class StudentsController < ApplicationController
  def index
    if params[:group_id]
      if Group.exists? params[:group_id]
        @students = User.students_by_group params[:group_id]
      else
        render plain: 'Not found', status: :not_found
      end
    else
      @students = User.students
    end
  end

  def show
    id = params[:id]
    if User.students.exists? id
      @student = User.students.find id
    else
      render plain: 'Not found', status: :not_found
    end
  end
end