angular.module 'tablesApp', ['spRestApi', 'spDirectives', 'ui.bootstrap']

.filter 'ifEmpty', ->
  (input, defaultValue) ->
    if angular.isUndefined(input) || input == null || input == ''
      defaultValue
    else
      input

.controller 'TablesCtrl', ['$scope', 'Auditories', 'Groups', 'Teachers', 'Subjects', 'Students', 'Users', ($scope, Auditories, Groups, Teachers, Subjects, Students, Users) ->
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

  $scope.$on 'studentsChanged', -> $scope.students = Students.query()
]

.controller 'UsersCtrl', ['$scope', 'Users', ($scope, Users) ->
  $scope.rolesList = ['admin', 'chief', 'student', 'teacher']
  $scope.rolesList = $.map $scope.rolesList, (role) ->
    id: role
    name: role
]

.controller 'StudentsCtrl', ['$scope', 'Students', ($scope, Students) ->
  $scope.update = (studentId, groupId) ->
    Students.update id: studentId,
      groupId: groupId
    , ->
      $scope.$emit 'studentsChanged'
]

.controller 'LessonsCtrl', ['$scope', 'Lessons', ($scope, Lessons) ->

  $scope.groupId = null
  $scope.setGroupId = (id) ->
    $scope.groupId = id

  $scope.date = new Date()
  $scope.time = (new Date()).setHours 15, 0, 0, 0

  $scope.lessons = Lessons.query ->

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
      $scope.lessons = Lessons.query()
]
