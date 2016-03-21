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

.directive 'spDropdown', ->
  restrict: 'E'
  scope:
    id: '=ngModel'
    list: '=list'
    title: '=title'
  templateUrl: '/angular/dropdown.html'
  link: (scope) ->
    scope.groups = [
        id: 1
        name: '1'
      ,
        id: 2
        name: '2'
    ]
    scope.setId = (id) ->
      scope.id = id
    scope.$watch 'list', (list) ->
      if list && list.length > 0
        scope.id = list[0].id
      else
        scope.id = null

    scope.$watch 'id', (id) ->
      if id
        scope.name = null
        if scope.list
          for item in scope.list
            scope.name = item.name if item.id == id

.directive 'spNameDescription', ['$injector', ($injector) ->
  restrict: 'E'
  scope: {}
  templateUrl: '/angular/name-description.html'
  link: (scope, element, attrs) ->
    Resource = $injector.get attrs.resource
    scope.objects = Resource.query()

    scope.update = (id, name, description) ->
      Resource.update id: id,
          name: name
          description: description
        ,
          scope.objects = Resource.query()

    scope.add = (name, description) ->
      Resource.save
          name: name
          description: description
        , ->
          scope.objects = Resource.query()

    scope.delete = (id) ->
      Resource.delete id: id, ->
        scope.objects = Resource.query()
]