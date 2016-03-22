angular.module 'tablesApp', ['spRestApi', 'spDirectives']

.filter 'ifEmpty', ->
  (input, defaultValue) ->
    if angular.isUndefined(input) || input == null || input == ''
      defaultValue
    else
      input

.filter 'parseDate', ->
  (input) ->
    if angular.isUndefined(input) || input == null || input == ''
      '-'
    else
      new Date(input).toString()

.controller 'TablesCtrl', ['$scope', 'Auditories', 'Groups', 'Teachers', 'Subjects', 'Students', 'Users', 'Lessons', ($scope, Auditories, Groups, Teachers, Subjects, Students, Users, Lessons) ->
  $scope.groups = Groups.query ->
    $scope.groupsList = $.map $scope.groups, (g) ->
      id: g.id
      name: g.name

  $scope.teachers = Teachers.query ->
    $scope.teachersList = $.map $scope.teachers, (t) ->
      id: t.id
      name: "#{t.lastName} #{t.firstName}"

  $scope.subjects = Subjects.query ->
    $scope.subjectsList = $.map $scope.subjects, (t) ->
      id: t.id
      name: t.name

  $scope.auditories = Auditories.query ->
    $scope.auditoriesList = $.map $scope.auditories, (a) ->
      id: a.id
      name: a.name

  $scope.students = Students.query()

  $scope.users = Users.query()

  $scope.lessons = Lessons.query()

  $scope.$on 'lessonsChanged', -> $scope.lessons = Lessons.query()

  $scope.$on 'studentsChanged', -> $scope.students = Students.query()

  $scope.$on 'usersChanged', ->
    $scope.teachers = Teachers.query ->
      $scope.teachersList = $.map $scope.teachers, (t) ->
        id: t.id
        name: "#{t.lastName} #{t.firstName}"

    $scope.users = Users.query()
]

.controller 'UsersCtrl', ['$scope', 'Users', ($scope, Users) ->
  $scope.rolesList = $.map ['admin', 'chief', 'student', 'teacher'], (role) ->
    id: role
    name: role
]

.controller 'UserRowCtrl', ['$scope', 'Users', ($scope, Users) ->
  $scope.turnOnEditMode = ->
    $scope.editMode = on
    $scope.e = $.extend {}, $scope.user

  $scope.turnOffEditMode = ->
    $scope.editMode = off

  $scope.update = ->
    Users.update id: $scope.e.id, $scope.e, ->
      $scope.editMode = off
      $scope.$emit 'usersChanged'

  $scope.add = ->
    Users.save $scope.e, ->
      $scope.$emit 'usersChanged'

  $scope.delete = ->
    Users.delete id: $scope.user.id, ->
      $scope.$emit 'usersChanged'
]

.controller 'StudentsCtrl', ['$scope', 'Students', ($scope, Students) ->
  $scope.update = (studentId, groupId) ->
    Students.update id: studentId,
      groupId: groupId
    , ->
      $scope.$emit 'studentsChanged'
]

.controller 'LessonsCtrl', ['$scope', 'Lessons', ($scope, Lessons) ->

  $scope.date = new Date()
  $scope.time = (new Date()).setHours 15, 0, 0, 0

  $scope.dateOptions =
    formatYear: 'yy'
    minDate: new Date()
    startingDay: 1

  $scope.openDatepicker = ->
    $scope.datepickerOpened = true

  $scope.addLesson = ->
    datetime = new Date $scope.date
    time = new Date $scope.time
    datetime.setHours time.getHours(), time.getMinutes(), 0, 0
    console.log datetime
    lesson = {}
    lesson.groupId = $scope.groupId
    lesson.teacherId = $scope.teacherId
    lesson.subjectId = $scope.subjectId
    lesson.auditoryId = $scope.auditoryId
    lesson.datetime = datetime
    Lessons.save lesson, ->
      $scope.$emit 'lessonsChanged'
]

.controller 'LessonRowCtrl', ['$scope', 'Lessons', ($scope, Lessons) ->
  $scope.turnOnEditMode = ->
    $scope.editMode = on
    $scope.e = $.extend {}, $scope.lesson

  $scope.turnOffEditMode = ->
    $scope.editMode = off

  $scope.update = ->
    Lessons.update id: $scope.lesson.id, $scope.e, ->
      $scope.$emit 'lessonsChanged'

  $scope.delete = ->
    Lessons.delete id: $scope.lesson.id, ->
      $scope.$emit 'lessonsChanged'
]