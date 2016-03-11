## Rest API

### POST /auditories
Example request `POST /auditories`
```
{
  "name": "313",
  "description": "Phisics laboratory"
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
### PUT /auditories/:id
Example request `UPDATE /auditories/5`
```
{
  "name": "215-a",
  "description": "Large auditory"
}
```
### DELETE /auditories/:id
Example request `DELETE /auditories/7`
### POST /groups
Example request `POST /groups`
```
{
  "name": "081-1004",
  "description": "2008 Computer science. Systems and technologies."
}
```
### GET /groups
Example request `GET /groups`
Example result
```
[
  {
    "id": 4,
    "name": "081-1004",
    "description": "2008 Computer science. Systems and technologies."
  },
  {
    "id": 7,
    "name": "081-1002",
    "description": "2008 Computer science. Computer machines and nets."
  }
]
```
### PUT /groups/:id
Example request `UPDATE /groups/4`
```
{
  "name": "081-1004",
  "description": "2008 FaI. Systems and technologies."
}
```
### DELETE /groups/:id
Example request `DELETE /groups/7`
### GET /groups/:id/students
Example request `GET /groups/4/students`
Example result
```
[
  {
    "id": 5,
    "firstName": "Ivan",
    "lastName": "Reshetnikov",
    "patronymic": "Alexandrovich"
  }
]
```
### POST /lessons
Example request `POST /lessons`
```
{
  "groupId": 2,
  "teacherId": 10,
  "subjectId": 3,
  "auditoryId": 7,
  "datetime": "2016-04-03T15:30:00+03"
}
```
### GET /lessons
Example request `GET /lessons`
Example result
```
[
  {
    "id": 6,
    "groupId": 2,
    "teacherId": 10,
    "subjectId": 3,
    "auditoryId": 7,
    "datetime": "2016-04-03T15:30:00+03"
  }
]
```
### PUT /lessons/:id
Example request `GET /lessons/6`
```
{
  "groupId": 2,
  "teacherId": 10,
  "subjectId": 3,
  "auditoryId": 7,
  "datetime": "2016-04-03T17:00:00+03"
}
```
### POST /marks
Example request `POST /marks`
```
{
  "mark": "4",
  "lessonId": 22,
  "studentId", 5
}
```
### GET /marks
Example request `GET /marks`
```
[
  {
    "id": 55,
    "lastMark": "4",
    "lessonId": 22
  },
  {
    "id": 56,
    "lastMark": "н",
    "lessonId": 27
  }
]
```
### GET /students
Example request `GET /students`
Example result
```
[
  {
    "id": 5,
    "firstName": "Ivan",
    "lastName": "Reshetnikov",
    "patronymic": "Alexandrovich"
  },
  {
    "id": 9,
    "firstName": "Sergey",
    "lastName": "Sergeev",
    "patronymic": "Sergeevich"
  }
]
```
### GET /students/:id/marks
Example request `GET /students/5/marks`
```
[
  {
    "id": 55,
    "lastMark": "4",
    "lessonId": 22
  },
  {
    "id": 56,
    "lastMark": "н",
    "lessonId": 27
  }
]
```
### POST /subjects
Example request `POST /subjects`
```
{
  "name": "History",
  "description": "..."
}
```
### GET /subjects
Example request `GET /subjects`
Example result
```
[
  {
    "id": 2,
    "name": "History",
    "description": "..."
  },
  {
    "id": 3,
    "name": "Computer graphics",
    "description": "..."
  }
]
```
### UPDATE /subjects/:id
Example request `UPDATE /subjects/3`
```
{
  "name": "Computer graphics",
  "description": "3D matrix transformations"
}
```
### DELETE /subjects/:id
Example request `DELETE /subjects/3`
### GET /teachers
Example request `GET /teachers`
Example result
```
[
  {
    "id": 55,
    "lastMark": "4",
    "lessonId": 22
  },
  {
    "id": 56,
    "lastMark": "н",
    "lessonId": 27
  }
]
```
### GET /teachers/:id/marks
Example request `GET /teachers/10/marks`
Example result
```
[
  {
    "id": 55,
    "lastMark": "4",
    "lessonId": 22
  }
]
```
### POST /users
```
{
  "id": 3,
  "firstName": "Ivan",
  "lastName": "Reshetnikov",
  "patronymic": "Alexandrovich",
  "email": "mail@example.com",
  "password": "p455w0rd",
}
```
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
### PUT /users/:id
Example request `PUT /users/3`
```
{
  "firstName": "Ivan",
  "lastName": "Reshetnikov",
  "patronymic": "Alexandrovich",
  "email": "another@example.com",
  "password": "p455w0rd"
}
```
