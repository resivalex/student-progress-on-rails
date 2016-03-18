angular.module 'tablesApp', ['spRestApi', 'spDirectives']

.controller 'LessonsCtrl', ['$scope', 'Auditories', 'Groups', 'Teachers', 'Subjects', 'Lessons', ($scope, Auditories, Groups, Teachers, Subjects, Lessons) ->
  $scope.groups = Groups.query()
  $scope.teachers = Teachers.query()
  $scope.subjects = Subjects.query()
  $scope.auditories = Auditories.query()

  $scope.time = (new Date()).toISOString()

  $scope.lessons = Lessons.query ->
    for lesson, index in $scope.lessons
      $scope.lessons[index].group = Groups.get id: $scope.lessons[index].groupId
    for lesson, index in $scope.lessons
      $scope.lessons[index].teacher = Teachers.get id: $scope.lessons[index].teacherId
    for lesson, index in $scope.lessons
      $scope.lessons[index].subject = Subjects.get id: $scope.lessons[index].subjectId
    for lesson, index in $scope.lessons
      $scope.lessons[index].auditory = Auditories.get id: $scope.lessons[index].auditoryId

  $scope.addLesson = ->
    lesson = {}
    lesson.groupId = $scope.groupId
    lesson.teacherId = $scope.teacherId
    lesson.subjectId = $scope.subjectId
    lesson.auditoryId = $scope.auditoryId
    lesson.datetime = $scope.time
    Lessons.save lesson, ->
      lessons = Lessons.query()
]
