angular.module 'tablesApp', ['spRestApi', 'spDirectives']

.controller 'LessonsCtrl', ['$scope', 'Auditories', 'Groups', 'Teachers', 'Subjects', 'Lessons', ($scope, Auditories, Groups, Teachers, Subjects, Lessons) ->
  $scope.groups = Groups.query()
  $scope.teachers = Teachers.query()
  $scope.subjects = Subjects.query()
  $scope.auditories = Auditories.query()

  $scope.time = (new Date()).toISOString()

  $scope.lessons = Lessons.query ->

  $scope.addLesson = ->
    lesson = {}
    lesson.groupId = $scope.groupId
    lesson.teacherId = $scope.teacherId
    lesson.subjectId = $scope.subjectId
    lesson.auditoryId = $scope.auditoryId
    lesson.datetime = $scope.time
    Lessons.save lesson, ->
      $scope.lessons = Lessons.query()
]
