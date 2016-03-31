angular.module 'spDirectives', ['ui.bootstrap']

angular.module 'spDirectives'

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
  templateUrl: '/angular/dropdown.html'
  link: (scope, element, attrs) ->
    scope.title = attrs.title

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
    scope.error = null

    onSuccess = ->
      scope.objects = Resource.query()
      scope.error = null

    onError = (error) ->
      scope.error = error

    scope.update = (id, name, description) ->
      Resource.update id: id,
          name: name
          description: description
        , onSuccess, onError

    scope.add = (name, description) ->
      Resource.save
          name: name
          description: description
        , onSuccess, onError

    scope.delete = (id) ->
      Resource.delete id: id, onSuccess, onError
]

.directive 'spRequestErrors', ->
  restrict: 'E'
  scope: {
    error: '=ngModel'
  }
  templateUrl: '/angular/request-errors.html'
