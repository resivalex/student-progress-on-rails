class StudentsController < ApplicationController
  before_filter :require_admin, only: [:create, :update]

  def index
    group_id = params[:group_id]
    lesson_id = params[:lesson_id]
    if group_id
      if Group.exists? group_id
        @students = User.students_by_group group_id
      else
        render_not_found
      end
    elsif lesson_id
      @students = Student.students_by_lesson_to_api lesson_id
    else
      @students = Student.students_to_api
    end
  end

  def create
    student = Student.create do |s|
      s.user_id = params[:userId]
      s.group_id = params[:groupId]
    end
    if student.save
      render nothing: true
    else
      render_bad_request student.errors
    end
  end

  def show
    @student = Student.by_id_to_api params[:id]
    unless @student
      render_not_found
    end
  end

  def update
    if Student.reassign params[:id], params[:groupId]
      render nothing: true
    else
      render_bad_request
    end
  end
end