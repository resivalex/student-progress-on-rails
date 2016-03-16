angular.module 'tablesApp', ['ngResource']

  .factory 'Auditory', ['$resource', ($resource) ->
    $resource '/auditories/:id'
  ]

  .controller 'AuditoryCtrl', ['$scope', 'Auditory', ($scope, Auditory) ->
    auditory = new Auditory()

    $scope.name = '123'
    $scope.description = '...'

    $scope.auditories = Auditory.query()

    $scope.saveAuditory = ->
      auditory.name = $scope.name
      auditory.description = $scope.description

      Auditory.save auditory, ->
        $scope.auditories = Auditory.query()
  ]