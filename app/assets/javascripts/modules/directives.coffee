angular.module 'spDirectives', []

angular.module 'spDirectives'
.directive 'spResourceTable', ['$injector', ($injector) ->
  restrict: 'E'
  scope:
    spF: '&spFields'
    spGetF: '&spGetFields'

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

    clearErrors = ->
      scope.errorCode = null
      scope.errors = null

    showErrors = (response) ->
      scope.errorCode = "#{response.status}: #{response.statusText}"
      scope.errors = response.data

    scope.saveResource = ->
      resource[i] = scope.adding[i] for i in scope.fields

      Resource.save resource, refreshList
      .$promise
      .then clearErrors
      .catch showErrors

    scope.updateResource = (index) ->
      a = scope.resources[index]
      Resource.update id: a.id, a, refreshList
      .$promise
      .then clearErrors
      .catch showErrors

    scope.deleteResource = (index) ->
      Resource.delete id: scope.resources[index].id, refreshList
      .$promise
      .then clearErrors
      .catch showErrors

    refreshList()
]

.directive 'spObjectsTable', ->
  restrict: 'E'
  scope:
    objects: '=spObjects'
    fields: '=spFields'
  templateUrl: '/angular/objects-table.html'
  link: (scope) ->
    unless scope.fields
      scope.fields = (key for key, value of objects)

.directive 'spSelectList', ->
  restrict: 'E'
  scope:
    items: '=spItems'
    id: '=spId'
  templateUrl: '/angular/select-list.html'
  link: (scope) ->
    scope.idChanged = (clickedId) ->
      scope.id = clickedId
