angular.module 'spRestApi', ['ngResource']

.factory 'Auditories', ['$resource', ($resource) ->
  $resource '/auditories/:id.json', null,
    update: { method: 'PUT' }
]
.factory 'Subjects', ['$resource', ($resource) ->
  $resource '/subjects/:id.json', null,
    update: { method: 'PUT' }
]
.factory 'Groups', ['$resource', ($resource) ->
  $resource '/groups/:id.json', null,
    update: { method: 'PUT' }
]
.factory 'Users', ['$resource', ($resource) ->
  $resource '/users/:id.json', null,
    update: { method: 'PUT' }
]
.factory 'Teachers', ['$resource', ($resource) ->
  $resource '/teachers/:id.json', null,
    update: { method: 'PUT' }
]
.factory 'Lessons', ['$resource', ($resource) ->
  $resource '/lessons/:id.json', null,
    update: { method: 'PUT' }
]
.factory 'Students', ['$resource', ($resource) ->
  $resource '/students/:id.json'
]