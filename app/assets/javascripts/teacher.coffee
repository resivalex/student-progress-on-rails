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

  $scope.$watch 'currentLessonId', (lessonId) ->
    if lessonId
      $scope.currentLesson = Lessons.get id: $scope.currentLessonId, ->
        cur = $scope.currentLesson
        $scope.currentGroup = Groups.get id: cur.groupId
        $scope.currentStudents = Groups.getStudents id: cur.groupId, ->
          $scope.studentsList = $.map $scope.currentStudents, (student) ->
            id: student.id
            name: "#{student.lastName} #{student.firstName} #{student.patronymic}"

  $scope.marks = Marks.query ->
    $scope.marksList = $.map $scope.marks, (mark) ->
      id: mark.id
      name: mark.mark

  $scope.addMark = ->
    console.log $scope.currentLessonId, $scope.currentStudentId
    Marks.save
        lessonId: $scope.currentLessonId
        studentId: $scope.currentStudentId
        mark: $scope.markName
      , -> console.log 'Added?'
]