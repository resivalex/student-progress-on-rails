class Admin::TablesController < AdminController
  def index
    @mark_tracks = MarkTrack.all
    @users = User.all
    @lessons = Lesson.all
    @marks = Mark.all
  end
end