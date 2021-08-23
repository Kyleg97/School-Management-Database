-- business problem #1
/*
 * Show every Student and their grade level (Junior, Senior, etc.)
 * that are enrolled in the specified course.
*/
SELECT Student.name, Student.grade
FROM Student
INNER JOIN Enrollment ON Enrollment.student_id = Student.student_id
INNER JOIN Course ON Course.course_id = Enrollment.course
WHERE Course.title = "Intro to Python"

-- business problem #2
/*
 * Find the grade average of the Course
 * specified by the user.
*/
SELECT AVG(Grade.score)
FROM Grade
INNER JOIN Enrollment ON Grade.course = Enrollment.course
INNER JOIN Course ON Enrollment.course = course_id
WHERE Course.title = "Intro to Java";

-- business problem #3
/*
 * Find the all Books written by the author specified
 * by the user stored in the Library also specified by the user.
*/
SELECT Book.title
FROM Book
INNER JOIN Library ON Library.library_id = 20
WHERE Book.author = "Kyle Gilbert"
AND Book.library_id = Library.library_id;

-- business problem #4
/*
 * Show all Faculty Members who work in the
 * department specified by the user.
*/
SELECT FacultyMember.name
FROM FacultyMember
INNER JOIN Department ON Department.department_id = FacultyMember.department
WHERE Department.name = "Physics";

-- business problem #4
/*
 * Show all Professors and the classes 
 * they teach who work in the department 
 * specified by the user
*/
SELECT FacultyMember.name, Course.title
FROM FacultyMember
INNER JOIN Department ON Department.department_id = FacultyMember.department
INNER JOIN Professor ON Professor.faculty_id = FacultyMember.faculty_id
INNER JOIN Course ON Course.professor = Professor.professor_id
WHERE Department.name = "Computer Science";

-- business problem #5
/*
 * Find all of the papers published
 * by every researcher with more
 * than the specified number of grants
*/
SELECT Papers.title
FROM Papers
INNER JOIN PublishPaper ON PublishPaper.publication_id = Papers.paper_id
INNER JOIN Researcher ON Researcher.researcher_id = PublishPaper.researcher
WHERE Researcher.num_of_grants > 3;

-- business problem #6
/*
 * Find all books and the student that has it 
 * currently checked out from the specified Library
*/
SELECT Book.title, Student.name
FROM Book
INNER JOIN RentBook ON Book.book_id = RentBook.book_id
INNER JOIN Library ON Book.library_id = Library.library_id
INNER JOIN Student ON Student.student_id = RentBook.student
WHERE Library.name = "JP Library";
