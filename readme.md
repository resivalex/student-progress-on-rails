# Student progress

- [JSON Rest API](#json-rest-api)
  - [HTTP status codes](#http-status-codes)
  - [/auditories](#auditories)
    - POST
    - GET
    - /:auditory_id
      - PUT
      - GET
      - DELETE
  - [/groups](#groups)
    - POST
    - GET
    - /:group_id
      - PUT
      - DELETE
      - /students
        - GET
  - [/lessons](#lessons)
    - POST
    - GET
    - /:lesson_id
      - PUT
      - GET
      - DELETE
      - /students
        - GET
  - [/marks](#marks)
    - POST
    - GET
    - /:mark_id
      - GET
      - /tracks
        - GET
  - [/students](#students)
    - POST
    - GET
    - /:student_id
      - GET
      - PUT
      - /marks
        - GET
  - [/subjects](#subjects)
    - POST
    - GET
    - /:subject_id
      - PUT
      - GET
      - DELETE
  - [/teachers](#teachers)
    - GET
    - /:teacher_id
      - GET
  - [/users](#users)
    - POST
    - GET
    - /:user_id
      - PUT
      - GET
      - DELETE

## JSON Rest API


### HTTP status codes
- `200: OK`
- `400: Bad request`
- `401: Unauthorized`
- `403: Forbidden`
- `404: Not Found`

### /auditories
- #### POST
  Example request `POST /auditories.json`
  ```
  {
    "name": "313",
    "description": "Phisics laboratory"
  }
  ```

- #### GET
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

- #### /:auditory_id
  - #### PUT
    Example request `PUT /auditories/5.json`
    ```
    {
      "name": "215-a",
      "description": "Large auditory"
    }
    ```

  - #### DELETE
    Example request `DELETE /auditories/7.json`

### /groups
- #### POST
  Example request `POST /groups.json`
  ```
  {
    "name": "081-1004",
    "description": "2008 Computer science. Systems and technologies."
  }
  ```

- #### GET
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

- #### /:group_id
  - #### PUT
    Example request `PUT /groups/4.json`
    ```
    {
      "name": "081-1004",
      "description": "2008 FaI. Systems and technologies."
    }
    ```

  - #### DELETE
    Example request `DELETE /groups/7.json`

  - #### /students
    - #### GET
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
- #### POST
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

- #### GET
  Example request `GET /lessons.json`

  Example result
  ```
  [
    {
      "id": 6,
      "groupId": 2,
      "group": "081-1004",
      "teacherId": 10,
      "teacher": "Gubarev Valentin Yurjevich",
      "subjectId": 3,
      "subject": "Math",
      "auditoryId": 7,
      "auditory": "215",
      "datetime": "2016-04-03T15:30:00+03"
    }
  ]
  ```
  
- #### /:lesson_id
  - #### GET
    Example request `GET /lessons/6.json`

    Example result
    ```
    {
      "groupId": 2,
      "group": "081-1004",
      "teacherId": 10,
      "teacher": "Gubarev Valentin Yurjevich",
      "subjectId": 3,
      "subject": "Math",
      "auditoryId": 7,
      "auditory": "215",
      "datetime": "2016-04-03T15:30:00+03"
    }
    ```

  - #### PUT
    Example request `PUT /lessons/6.json`
    ```
    {
      "groupId": 2,
      "teacherId": 10,
      "subjectId": 3,
      "auditoryId": 7,
      "datetime": "2016-04-03T17:00:00+03"
    }
    ```

  - #### DELETE
    Example request `DELETE /lessons/6.json`

  - #### /students
    - #### GET
      Example request `GET /lessons/6/students.json`

      Example response
      ```
      [
        {
          "studentId": 5,
          "markId": 55,
          "mark": "4",
          "comment": "Well",
          "firstName": "Ivan",
          "lastName": "Reshetnikov",
          "patronymic": "Alexandrovich"
        },
        {
          "studentId": 6,
          "markId": null,
          "mark": null,
          "comment": null,
          "firstName": "Sergey",
          "lastName": "Sergeev",
          "patronymic": "Sergeevich"
        }
      ]
      ```

### /marks
- #### POST
  Example request `POST /marks.json`
  ```
  {
    "mark": "4",
    "comment": "Well",
    "lessonId": 22,
    "studentId": 5
  }
  ```

- #### GET
  Example request `GET /marks.json`
  ```
  [
    {
      "id": 55,
      "mark": "4",
      "comment": "Well",
      "lessonId": 22,
      "studentId": 5
    },
    {
      "id": 56,
      "mark": "н",
      "comment": "Absent"
      "lessonId": 27,
      "studentId": 3
    }
  ]
  ```

- #### /:mark_id
  - #### GET
    Example request `GET /marks/55.json`

    Example result
    ```
    {
      "mark": "4",
      "comment": "Well",
      "lessonId": 22,
      "studentId": 5
    }
    ```

  - #### /tracks
    - #### GET
      Example request `GET /marks/55/tracks.json`

      Example result
      ```
      [
        {
          "mark": "2",
          "comment": "No book",
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
- #### POST
  Example request `POST /students.json`
  ```
  {
    studentId: 5,
    groupId: 2
  }
  ```

- #### GET
  Example request `GET /students.json`

  Example result
  ```
  [
    {
      "id": 5,
      "groupId": "2",
      "group": "081-1004",
      "firstName": "Ivan",
      "lastName": "Reshetnikov",
      "patronymic": "Alexandrovich"
    },
    {
      "id": 9,
      "groupId": null,
      "group": null,
      "firstName": "Sergey",
      "lastName": "Sergeev",
      "patronymic": "Sergeevich"
    }
  ]
  ```

- #### /:student_id
  - #### GET
    Example request `GET /students/5.json`

    Example result
    ```
    {
      "firstName": "Ivan",
      "lastName": "Reshetnikov",
      "patronymic": "Alexandrovich",
      "groupId": 2,
      "group": "081-1004"
    }
    ```

  - #### PUT
    Example request `PUT /students/5.json`
    ```
    {
      "groupId": 3
    }
    ```

  - #### /marks
    - #### GET
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

### /subjects
- #### POST
  Example request `POST /subjects.json`
  ```
  {
    "name": "History",
    "description": "..."
  }
  ```

- #### GET
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

- #### /:subject_id
  - #### PUT
    Example request `PUT /subjects/3.json`
    ```
    {
      "name": "Computer graphics",
      "description": "3D matrix transformations"
    }
    ```

  - #### GET
    Example request `GET /subjects/3.json`

    Example result
    ```
    {
      "name": "Computer graphics",
      "description": "..."
    }
    ```

  - #### DELETE
    Example request `DELETE /subjects/3.json`

### /teachers
- #### GET
  Example request `GET /teachers.json`

  Example result
  ```
  [
    {
      "id": 10,
      "firstName": "Valentin",
      "lastName": "Gubarev",
      "patronymic": "Yurjevich"
    }
  ]
  ```

  - #### /:teacher_id
    - #### GET
      Example request `GET /teachers/10.json`

      Example result
      ```
      {
        "id": 10,
        "firstName": "Valentin",
        "lastName": "Gubarev",
        "patronymic": "Yurjevich"
      }
      ```

### /users
- #### POST
  ```
  {
    "id": 3,
    "firstName": "Ivan",
    "lastName": "Reshetnikov",
    "patronymic": "Alexandrovich",
    "email": "mail@example.com",
    "password": "p455w0rd",
    "phone": "123-456"
  }
  ```

- #### GET
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
      "role": "student",
      "phone": "123-456"
    }
  ]
  ```

- #### /:user_id
  - #### PUT
    Example request `PUT /users/3.json`
    ```
    {
      "firstName": "Ivan",
      "lastName": "Reshetnikov",
      "patronymic": "Alexandrovich",
      "email": "another@example.com",
      "password": "p455w0rd",
      "phone": "123-456"
    }
    ```

  - #### GET
    Example request `GET /users/3.json`

    Example result
    ```
    {
      "id": 3,
      "firstName": "Ivan",
      "lastName": "Reshetnikov",
      "patronymic": "Alexandrovich",
      "email": "mail@example.com",
      "role": "student",
      "phone": "123-456"
    }
    ```

  - #### DELETE
    Example request `DELETE /users/3.json`
