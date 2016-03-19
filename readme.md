Table of contents
- [JSON Rest API](#json-rest-api)
  - [HTTP status codes](#http-status-codes)
  - [/auditories](#auditories)
    - [POST](#post)
    - [GET](#get)
    - [/:auditory_id](#auditory_id)
      - [PUT](#put)
      - [GET](#get)
      - [DELETE](#delete)
  - [/groups](#groups)
    - [POST](#post)
    - [GET](#get)
    - [/:group_id](#group_id)
      - [PUT](#put)
      - [DELETE](#delete)
      - [/students](#students)
        - [GET](#get)
  - [/lessons](#lessons)
    - [POST](#post)
    - [GET](#get)
    - [/:lesson_id](#lesson_id)
      - [PUT](#put)
      - [GET](#get)
      - [DELETE](#delete)
  - [/marks](#marks)
    - [POST](#post-marks)
    - [GET](#get-marks)
    - [/:mark_id](#mark_id)
      - [GET](#get)
      - [/tracks](#tracks)
        - [GET](#get)
  - [/students](#students)
    - [POST](#post)
    - [GET](#get)
    - [/:student_id](#student_id)
      - [GET](#get)
      - [/marks](#marks)
        - [GET](#get)
  - [/subjects](#subjects)
    - [POST](#post)
    - [GET](#get)
    - [/:subject_id](#subject_id)
      - [PUT](#put)
      - [GET](#get)
      - [DELETE](#delete)
  - [/teachers](#teachers)
    - [GET](#get)
    - [/:teacher_id](#teacher_id)
      - [GET /marks](#marks)
  - [/users](#users)
    - [POST](#post-users)
    - [GET](#get-users)
    - [/:user_id](#user_id)
      - [PUT](#put)
      - [GET](#get)
      - [DELETE](#delete)

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
      "teacherId": 10,
      "subjectId": 3,
      "auditoryId": 7,
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
      "teacherId": 10,
      "subjectId": 3,
      "auditoryId": 7,
      "datetime": "2016-04-03T17:00:00+03"
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
      "firstName": "Ivan",
      "lastName": "Reshetnikov",
      "patronymic": "Alexandrovich"
    },
    {
      "id": 9,
      "groupId": null,
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
      "patronymic": "Alexandrovich"
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
  - #### /marks
    - #### GET
      Example request `GET /teachers/10/marks.json`

      Example result
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

### /users
- #### POST
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
      "login": "login1",
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
      "login": "login1",
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
      "login": "login1",
      "role": "student",
      "phone": "123-456"
    }
    ```

  - #### DELETE
    Example request `DELETE /users/3.json`
