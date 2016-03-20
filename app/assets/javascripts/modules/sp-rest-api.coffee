angular.module 'spRestApi', ['ngResource']

.factory 'Auditories', ['$resource', ($resource) ->
  $resource '/auditories/:id.json', null,
    update: method: 'PUT'
]
.factory 'Subjects', ['$resource', ($resource) ->
  $resource '/subjects/:id.json', null,
    update: method: 'PUT'
]
.factory 'Groups', ['$resource', ($resource) ->
  $resource '/groups/:id/:action.json', null,
    update: method: 'PUT'
    getStudents:
      method: 'GET'
      params:
        action: 'students'
      isArray: true
]
.factory 'Users', ['$resource', ($resource) ->
  $resource '/users/:id.json', null,
    update: method: 'PUT'
]
.factory 'Teachers', ['$resource', ($resource) ->
  $resource '/teachers/:id.json', null,
    update: method: 'PUT'
]
.factory 'Lessons', ['$resource', ($resource) ->
  $resource '/lessons/:id/:action.json', null,
    update: method: 'PUT'
    getStudents:
      method: 'GET'
      params:
        action: 'students'
      isArray: true
]
.factory 'Students', ['$resource', ($resource) ->
  $resource '/students/:id.json'
]
.factory 'Marks', ['$resource', ($resource) ->
  $resource '/marks/:id/:action.json', null,
    tracks:
      method: 'GET'
      params:
        action: 'tracks'
      isArray: true
]