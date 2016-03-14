Table of contents
- [JSON Rest API](#json-rest-api)
  - [HTTP status codes](#http-status-codes)
  - [/auditories](#auditories)
    - [POST /](#post)
    - [GET /](#get)
    - [/:auditory_id](#auditory_id)
      - [GET /](#get)
      - [PUT /](#put)
      - [DELETE /](#delete)
  - [/groups](#groups)
    - [POST /](#post)
    - [GET /](#get)
    - [/:group_id](#group_id)
      - [PUT /](#put)
      - [DELETE /](#delete)
      - [/students](#students)
        - [GET /](#get)
  - [/lessons](#lessons)
    - [POST /](#post)
    - [GET /](#get)
    - [/:lesson_id](#lesson_id)
      - [PUT /](#put)
      - [GET /](#get)
      - [DELETE /](#delete)
  - [/marks](#marks)
    - [POST /](#post-marks)
    - [GET /](#get-marks)
    - [/:mark_id](#mark_id)
      - [GET /](#get)
      - [/tracks](#tracks)
        - [GET /](#get)
  - [/students](#students)
    - [GET /](#get)
    - [/:student_id](#student_id)
      - [GET /](#get)
      - [/marks](#marks)
        - [GET /](#get)
  - [/subjects](#subjects)
    - [POST /](#post)
    - [GET /](#get)
    - [/:subject_id](#subject_id)
      - [PUT /](#put)
      - [DELETE /](#delete)
  - [/teachers](#teachers)
    - [GET /](#get)
    - [/:teacher_id](#teacher_id)
      - [GET /marks](#marks)
  - [/users](#users)
    - [POST /](#post-users)
    - [GET /](#get-users)
    - [/:user_id](#user_id)
      - [PUT /](#put)
      - [GET /](#get)
      - [DELETE /](#delete)

## JSON Rest API


### HTTP status codes
- `200: OK`
- `400: Bad request`
- `401: Unauthorized`
- `403: Forbidden`
- `404: Not Found`

### /auditories
- ### POST /auditories
  Example request `POST /auditories.json`
  ```
  {
    "name": "313",
    "description": "Phisics laboratory"
  }
  ```
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
- ### PUT /auditories/:id
  Example request `UPDATE /auditories/5.json`
  ```
  {
    "name": "215-a",
    "description": "Large auditory"
  }
  ```
- ### DELETE /auditories/:id
  Example request `DELETE /auditories/7.json`
- ### POST /groups
- #### POST
- #### GET
  Example request `POST /groups.json`
  ```
  {
    "name": "081-1004",
    "description": "2008 Computer science. Systems and technologies."
  }
  ```
### /groups
- ### GET /groups
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
- ### PUT /groups/:id
  Example request `UPDATE /groups/4.json`
  ```
  {
    "name": "081-1004",
    "description": "2008 FaI. Systems and technologies."
  }
  ```
- ### DELETE /groups/:id
  Example request `DELETE /groups/7.json`
- ### GET /groups/:id/students
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
### /lessons
- ### POST /lessons
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
- ### GET /lessons
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
- ### PUT /lessons/:id
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
- ### DELETE /lessons/:id
  Example request `DELETE /lessons/6.json`
- ### GET /lessons/:id
  Example request `GET /lessons/6.json`

  Example result
  ```
  {
    "groupId": 2,
    "teacherId": 10,
    "subjectId": 3,
    "auditoryId": 7,
    "datetime": "2016-04-03T17:00:00+03"
  }
  ```
### /marks
- ### POST /marks
  Example request `POST /marks.json`
  ```
  {
    "mark": "4",
    "comment": "Well",
    "lessonId": 22,
    "studentId", 5
  }
  ```
- ### GET /marks
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
- ### GET /marks/:id
  Example request `GET /marks/55.json`

  Example result
  ```
  {
    "mark": "4",
    "lessonId": 22
  }
  ```
- ### GET /marks/:id/tracks
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
### /students
- ### GET /students
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
- ### GET /students/:id
  Example request `GET /students/5.json`

  Example result
  ```
  {
    "firstName": "Ivan",
    "lastName": "Reshetnikov",
    "patronymic": "Alexandrovich"
  }
- ### GET /students/:id/marks
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
- ### POST /subjects
  Example request `POST /subjects.json`
  ```
  {
    "name": "History",
    "description": "..."
  }
  ```
### /subjects
- ### GET /subjects
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
- ### PUT /subjects/:id
  Example request `UPDATE /subjects/3.json`
  ```
  {
    "name": "Computer graphics",
    "description": "3D matrix transformations"
  }
  ```
- ### DELETE /subjects/:id
  Example request `DELETE /subjects/3.json`
### /teachers
- ### GET /teachers
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
- ### GET /teachers/:id/marks
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
### /users
- ### POST /users
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
- ### GET /users
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
- ### PUT /users/:id
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
- ### DELETE /users/:id
  Example request `DELETE /users/3.json`

- ### GET /users/:id
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