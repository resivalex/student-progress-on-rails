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
    query = <<-SQL
      SELECT users.id AS id, group_id, first_name, last_name, patronymic
      FROM users
      LEFT OUTER JOIN students ON users.id = students.user_id
      WHERE role = 'student'
    SQL
    @students = ActiveRecord::Base.connection.execute query
    @students = @students.select{ |s| s['id'].to_s == params[:id] }

    @student = @students.first
    if @student
      f = @student
      s = {
        group_id: f['group_id'],
        first_name: f['first_name'],
        last_name: f['last_name'],
        patronymic: f['patronymic'],
      }
      @student = OpenStruct.new s
    end
    unless @student
      render plain: 'Not found', status: :not_found
    end
  end
end