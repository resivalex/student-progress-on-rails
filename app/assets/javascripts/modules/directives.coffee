angular.module 'spDirectives', []

angular.module 'spDirectives'
.directive 'spResourceTable', ['$injector', ($injector) ->
  restrict: 'E'
  scope: {
    spF: '&spFields'
    spGetF: '&spGetFields'
  }
  templateUrl: '/angular/resource-table.html'
  link: (scope, element, attrs) ->
    Resource = $injector.get attrs.spResource
    resource = new Resource()

    scope.header = attrs.spResource
    scope.fields = scope.spF()
    scope.getFields = scope.spGetF()
    scope.getFields ?= scope.fields

    scope.adding = []
    scope.adding[i] = i for i in scope.fields

    scope.turnOnEditMode = (index) -> scope.resources[index].editMode = true
    scope.turnOffEditMode = (index) -> scope.resources[index].editMode = false
    scope.inEditMode = (index) -> scope.resources[index].editMode

    refreshList = ->
      scope.resources = Resource.query()

    refreshList()

    scope.saveResource = ->
      resource[i] = scope.adding[i] for i in scope.fields

      Resource.save resource, refreshList
      .$promise
      .then ->
        scope.errorCode = null
        scope.errors = null
      .catch (response) ->
        scope.errorCode = "#{response.status}: #{response.statusText}"
        scope.errors = response.data

    scope.updateResource = (index) ->
      a = scope.resources[index]
      Resource.update id: a.id, a, refreshList
      .$promise
      .then ->
        scope.errorCode = null
        scope.errors = null
      .catch (response) ->
        scope.errorCode = "#{response.status}: #{response.statusText}"
        scope.errors = response.data

    scope.deleteResource = (index) ->
      Resource.delete id: scope.resources[index].id, refreshList
      .$promise
      .then ->
        scope.errorCode = null
        scope.errors = null
      .catch (response) ->
        scope.errorCode = "#{response.status}: #{response.statusText}"
        scope.errors = response.data
]