angular.module 'teacherApp', ['spRestApi', 'spDirectives']

.filter 'lessonString', ->
  (input) -> input

.controller 'LessonsCtrl', ['$scope', 'Lessons', ($scope, Lessons) ->
  $scope.lessons = Lessons.query()
  $scope.objects = [
      a: 'b',
    ,
      a: 'c'
  ]
]

.controller 'JournalCtrl', ['$scope', 'Lessons', 'Groups', 'Marks', ($scope, Lessons, Groups, Marks) ->
  $scope.lessons = Lessons.query ->
    $scope.lessonsList = $.map $scope.lessons, (lesson) ->
      id: lesson.id
      name: lesson.datetime

  $scope.marksList = $.map ['5', '4', '3', '2', 'н'], (mark) ->
    id: mark
    name: mark

  $scope.$watch 'currentLessonId', (lessonId) ->
    if lessonId
      $scope.currentStudentId = null
      currentLesson = Lessons.get id: lessonId, ->
        $scope.students = Lessons.getStudents id: lessonId, ->
          $scope.studentsList = $.map $scope.students, (l) ->
            id: l.id
            name: "#{l.lastName} #{l.firstName} #{l.patronymic} #{l.mark ? 'No mark'}"
    else
      $scope.students = null
      $scope.studentsList = null
      $scope.currentStudentId = null

  $scope.$watch 'currentStudentId', (studentId) ->
    if studentId
      $scope.currentMarkId = if $scope.students
        currentStudent = null
        for i in $scope.students
          currentStudent = i if i.id == studentId
        if currentStudent
          $scope.currentMarkId = currentStudent.markId
        else
          $scope.currentMarkId = null
    else
      $scope.currentMarkId = null

  $scope.$watch 'currentMarkId', (markId) ->
    $scope.markTracks = if markId
      Marks.tracks id: markId, -> $scope.markTracks.reverse()
    else
      []

  $scope.addMark = ->
    console.log $scope.currentLessonId, $scope.currentStudentId
    Marks.save
        lessonId: $scope.currentLessonId
        studentId: $scope.currentStudentId
        mark: $scope.markName
        comment: $scope.markComment
      , ->
        $scope.markTracks = if $scope.currentMarkId
          Marks.tracks id: $scope.currentMarkId, -> $scope.markTracks.reverse()
        else
          []
]