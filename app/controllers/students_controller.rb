class StudentsController < ApplicationController
  def index
    group_id = params[:group_id]
    lesson_id = params[:lesson_id]
    if group_id
      if Group.exists? group_id
        @students = User.students_by_group group_id
      else
        render plain: 'Not found', status: :not_found
      end
    elsif lesson_id
      @students = Student.students_by_lesson_to_api lesson_id
    else
      @students = User.students
    end
  end

  def create
    student = Student.create do |s|
      s.user_id = params[:userId]
      s.group_id = params[:groupId]
    end
    if student.save
      render plain: 'OK'
    else
      render plain: 'Bad request', status: :bad_request
    end
  end

  def show
    @student = Student.by_id_to_api params[:id]
    unless @student
      render plain: 'Not found', status: :not_found
    end
  end
end