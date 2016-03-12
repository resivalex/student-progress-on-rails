Table of contents
- [JSON Rest API](#json-rest-api)
  - [HTTP status codes](#http-status-codes)
  - [POST /auditories](#post-auditories)
  - [GET /auditories](#get-auditories)
  - [PUT /auditories/:id](#put-auditoriesid)
  - [DELETE /auditories/:id](#delete-auditoriesid)
  - [POST /groups](#post-groups)
  - [GET /groups](#get-groups)
  - [PUT /groups/:id](#put-groupsid)
  - [DELETE /groups/:id](#delete-groupsid)
  - [GET /groups/:id/students](#get-groupsidstudents)
  - [POST /lessons](#post-lessons)
  - [GET /lessons](#get-lessons)
  - [PUT /lessons/:id](#put-lessonsid)
  - [DELETE /lessons/:id](#delete-lessonsid)
  - [POST /marks](#post-marks)
  - [GET /marks](#get-marks)
  - [GET /marks/:id](#get-marks-id)
  - [GET /marks/:id/tracks](#get-marksidtracks)
  - [GET /students](#get-students)
  - [GET /students/:id/marks](#get-studentsidmarks)
  - [POST /subjects](#post-subjects)
  - [GET /subjects](#get-subjects)
  - [PUT /subjects/:id](#put-subjectsid)
  - [DELETE /subjects/:id](#delete-subjectsid)
  - [GET /teachers](#get-teachers)
  - [GET /teachers/:id/marks](#get-teachersidmarks)
  - [POST /users](#post-users)
  - [GET /users](#get-users)
  - [PUT /users/:id](#put-usersid)
  - [DELETE /users/:id](#delete-usersid)
  - [GET /users/:id](#get-usersid)

## JSON Rest API


### HTTP status codes
- `200: OK`
- `401: Unauthorized`
- `403: Forbidden`
- `404: Not Found`

### POST /auditories
Example request `POST /auditories.json`
```
{
  "name": "313",
  "description": "Phisics laboratory"
}
```
### GET /auditories
Example request `GET /auditories.json`

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
Example request `UPDATE /auditories/5.json`
```
{
  "name": "215-a",
  "description": "Large auditory"
}
```
### DELETE /auditories/:id
Example request `DELETE /auditories/7.json`
### POST /groups
Example request `POST /groups.json`
```
{
  "name": "081-1004",
  "description": "2008 Computer science. Systems and technologies."
}
```
### GET /groups
Example request `GET /groups.json`

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
Example request `UPDATE /groups/4.json`
```
{
  "name": "081-1004",
  "description": "2008 FaI. Systems and technologies."
}
```
### DELETE /groups/:id
Example request `DELETE /groups/7.json`
### GET /groups/:id/students
Example request `GET /groups/4/students.json`

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
Example request `POST /lessons.json`
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
Example request `GET /lessons.json`

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
Example request `GET /lessons/6.json`
```
{
  "groupId": 2,
  "teacherId": 10,
  "subjectId": 3,
  "auditoryId": 7,
  "datetime": "2016-04-03T17:00:00+03"
}
```
### DELETE /lessons/:id
Example request `DELETE /lessons/6.json`
### POST /marks
Example request `POST /marks.json`
```
{
  "mark": "4",
  "comment": "Well",
  "lessonId": 22,
  "studentId", 5
}
```
### GET /marks
Example request `GET /marks.json`
```
[
  {
    "id": 55,
    "mark": "4",
    "comment": "Well",
    "lessonId": 22
  },
  {
    "id": 56,
    "mark": "н",
    "comment": "Absent"
    "lessonId": 27
  }
]
```
### GET /marks/:id
Example request `GET /marks/55.json`

Example result
```
{
  "mark": "4",
  "lessonId": 22
}
```
### GET /marks/:id/tracks
Example request `GET /marks/55/tracks.json`

Example result
```
[
  {
    "mark": "2",
    "comment": "No book"
    "datetime": "2016-04-03T17:06:34+03"
  },
  {
    "mark": "4",
    "comment": "",
    "datetime": "2016-04-05T12:20:57+03"
  }
]
```
### GET /students
Example request `GET /students.json`

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
Example request `GET /students/5/marks.json`
```
[
  {
    "id": 55,
    "mark": "4",
    "lessonId": 22
  },
  {
    "id": 56,
    "mark": "н",
    "lessonId": 27
  }
]
```
### POST /subjects
Example request `POST /subjects.json`
```
{
  "name": "History",
  "description": "..."
}
```
### GET /subjects
Example request `GET /subjects.json`

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
### PUT /subjects/:id
Example request `UPDATE /subjects/3.json`
```
{
  "name": "Computer graphics",
  "description": "3D matrix transformations"
}
```
### DELETE /subjects/:id
Example request `DELETE /subjects/3.json`
### GET /teachers
Example request `GET /teachers.json`

Example result
```
[
  {
    "id": 55,
    "mark": "4",
    "lessonId": 22
  },
  {
    "id": 56,
    "mark": "н",
    "lessonId": 27
  }
]
```
### GET /teachers/:id/marks
Example request `GET /teachers/10/marks.json`

Example result
```
[
  {
    "id": 55,
    "mark": "4",
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
  "login": "login1",
  "password": "p455w0rd",
  "phone": "123-456"
}
```
### GET /users
Example request `GET /users.json`

Example result
```
[
  {
    "id": 3,
    "firstName": "Ivan",
    "lastName": "Reshetnikov",
    "patronymic": "Alexandrovich",
    "email": "mail@example.com",
    "login": "login1",
    "role": "student",
    "phone": "123-456"
  }
]
```
### PUT /users/:id
Example request `PUT /users/3.json`
```
{
  "firstName": "Ivan",
  "lastName": "Reshetnikov",
  "patronymic": "Alexandrovich",
  "email": "another@example.com",
  "login": "login1",
  "password": "p455w0rd",
  "phone": "123-456"
}
```
### DELETE /users/:id
Example request `DELETE /users/3.json`

### GET /users/:id
Example request `GET /users/3.json`

Example result
```
{
  "id": 3,
  "firstName": "Ivan",
  "lastName": "Reshetnikov",
  "patronymic": "Alexandrovich",
  "email": "mail@example.com",
  "login": "login1",
  "role": "student",
  "phone": "123-456"
}
```