$ ->
  fillCredentials = (email, password) ->
    $('.email').val email
    $('.password').val password

  $('.as-admin').click ->
    fillCredentials 'admin@example.com', '123456'

  $('.as-teacher').click ->
    fillCredentials 'petr@example.com', '654321'

  $('.as-student').click ->
    fillCredentials 'ivan@example.com', '343434'

  $('.as-chief').click ->
    fillCredentials 'boris@example.com', '111111'