# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print("Bot failed to create a connection with your database because your secret environment variables " +
              "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
        print("\n")

# your code here
# maybe database query functions?

def handle_msg(msg):
    response = ""
    print("inside handle_msg")
    args = msg.split()
    command = args[0]
    if len(args) < 2:
      return "Not enough arguments"
    param = ""
    for each in args:
        if each != command:
          param += each
          param += " "
    # business problem 1
    if command == "students":
        result = business_problem_1(param)
        for each in result:
          toAppend = each['name'] + ", " + each['grade'] + "\n"
          response += toAppend
    # business problem 2
    elif command == "gpa":
        result = business_problem_2(param)
        for each in result:
          toAppend = str(each['AVG(Grade.score)'])
          response += toAppend
    # business problem 3
    elif command == "booksby":
        authorParam = args[1] + " " + args[2]
        libraryParam = args[3] + " " + args[4]
        result = business_problem_3(authorParam, libraryParam)
        for each in result:
          toAppend = each['title'] + "\n"
          response += toAppend
    # business problem 4
    elif command == "professors":
        result = business_problem_4(param)
        for each in result:
          toAppend = str(each['name'] + "\n")
          response += toAppend
    # business problem 5
    elif command == "grantpapers":
        result = business_problem_5(param)
        for each in result:
          toAppend = str(each['title'] + "\n")
          response += toAppend
    # business problem 6
    elif command == "checkedbooks":
        result = business_problem_6(param)
        for each in result:
          toAppend = each['title'] + ", " + each['name'] + "\n"
          response += toAppend
    else:
        response = "Unknown command"
    return response

def business_problem_1(param):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(F"""SELECT Student.name, Student.grade
                  FROM Student
                  INNER JOIN Enrollment ON Enrollment.student_id = Student.student_id
                  INNER JOIN Course ON Course.course_id = Enrollment.course
                  WHERE Course.title = "{param}";""")
    query_result = cursor.fetchall()
    cursor.close()
    return query_result

def business_problem_2(param):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(F"""SELECT AVG(Grade.score)
                  FROM Grade
                  INNER JOIN Enrollment ON Grade.course = Enrollment.course
                  INNER JOIN Course ON Enrollment.course = course_id
                  WHERE Course.title = "{param}";""")
    query_result = cursor.fetchall()
    cursor.close()
    return query_result

def business_problem_3(authorName, libName):
    conn = connect()
    cursor = conn.cursor()
    print(authorName)
    print(libName)
    cursor.execute(F"""SELECT Book.title FROM Book 
                    INNER JOIN Library ON Library.name = "{libName}"
                    WHERE Book.author = "{authorName}" 
                    AND Book.library_id = Library.library_id;""")
    query_result = cursor.fetchall()
    cursor.close()
    return query_result

def business_problem_4(param):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(F"""SELECT FacultyMember.name
                      FROM FacultyMember
                      INNER JOIN Department ON Department.department_id = FacultyMember.department
                      INNER JOIN Professor ON Professor.faculty_id = FacultyMember.faculty_id
                      WHERE Department.name = "{param}";""")
    query_result = cursor.fetchall()
    cursor.close()
    return query_result

def business_problem_5(param):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(F"""SELECT Papers.title
                      FROM Papers
                      INNER JOIN PublishPaper ON PublishPaper.publication_id = Papers.paper_id
                      INNER JOIN Researcher ON Researcher.researcher_id = PublishPaper.researcher
                      WHERE Researcher.num_of_grants > {param};""")
    query_result = cursor.fetchall()
    cursor.close()
    return query_result

def business_problem_6(param):
    conn = connect()
    cursor = conn.cursor()
    cursor.execute(F"""SELECT Book.title, Student.name
                  FROM Book
                  INNER JOIN RentBook ON Book.book_id = RentBook.book_id
                  INNER JOIN Library ON Book.library_id = Library.library_id
                  INNER JOIN Student ON Student.student_id = RentBook.student
                  WHERE Library.name = "{param}";""")
    query_result = cursor.fetchall()
    cursor.close()
    return query_result