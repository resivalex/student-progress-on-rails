## Rest API

### POST /auditories
Example request `POST /auditories`
```
{
  "name": "313",
  "description": "Phisics laboratory"
}
```
Example result
```
{
  "status": "OK"
}
```
### GET /auditories
Example request `GET /auditories`
Example result
```
[
  {
    "id": 5,
    "name": "215a",
    "description": "Large auditory"
  },
  {
    "id": 7,
    "name": "100",
    "description": "Auditory near entrance"
  }
]
```
### UPDATE /auditories/:id
Example request `UPDATE /auditories/5`
```
{
  "name": "215-a",
  "description": "Large auditory"
}
```
### DELETE /auditories/:id
Example request `DELETE /auditories/7`
Example result
```
{
  "status": "OK"
}
```
### GET /groups
### GET /lessons
### GET /marks
### GET /students
### GET /subjects
### GET /users
Example request `GET /users`
Example result
```
[
  {
    "id": 3,
    "firstName": "Ivan",
    "lastName": "Reshetnikov",
    "patronymic": "Alexandrovich",
    "email": "mail@example.com",
    "role": "student"
  }
]
```



