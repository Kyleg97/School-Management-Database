-- Script name: tests.sql
-- Author: Kyle Gilbert
-- Purpose: Test the integrity of the database system

-- the database used to insert the data into
USE CollegeDB;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM School WHERE school_id = 2;
UPDATE School SET school_id = 2 WHERE name = "Cabrillo College";

DELETE FROM Library WHERE library_id = 22;
UPDATE Library SET book_count = 100;

DELETE FROM Book WHERE book_id = 5;
UPDATE Book SET library_id = 21 WHERE book_id = 4;

DELETE FROM Student WHERE name = "Ryland Denny";
UPDATE Student SET student_id = 92019 WHERE name = "Daniel Rodriguez";

DELETE FROM Department WHERE name = "Herbology";
UPDATE Department SET department_chair = "Hilbert" WHERE name = "Computer Science";

#DELETE FROM FacultyMember WHERE faculty_id = 1;
#UPDATE FacultyMember SET is_chair = 1 WHERE faculty_id = 3;

DELETE FROM Course WHERE course_id = 403;
UPDATE Course SET seats = seats + 1 WHERE course_id = 400;

DELETE FROM Enrollment WHERE enrollment_id = 3;
UPDATE Enrollment SET semester = "Summer" WHERE enrollment_id = 2;

DELETE FROM TeacherAssistant WHERE ta_id = 3;
UPDATE TeacherAssistant SET monthly_pay = monthly_pay + 1 WHERE ta_id = 1;

DELETE FROM ResearchAssistant WHERE research_assistant_id = 3;
UPDATE ResearchAssistant SET work_hours_weekly = work_hours_weekly + 1 WHERE research_assistant_id = 1;

DELETE FROM PublishPaper WHERE publication_id = 3;
UPDATE PublishPaper SET conference = "New York Conference" WHERE publication_id = 2;

DELETE FROM Grader WHERE grader_id = 3;
UPDATE Grader SET student = 92014 WHERE grader_id = 2;

DELETE FROM Grade WHERE grade_id = 3;
UPDATE Grade SET score = 90 WHERE grade_id = 1;

DELETE FROM PublishGrade WHERE publish_grade_id = 3;
UPDATE PublishGrade SET student = 92015 WHERE publish_grade_id = 3;

DELETE FROM RentBook WHERE rent_id = 4;
UPDATE RentBook SET student = 92014 WHERE rent_id = 2;

DELETE FROM PayFee WHERE student = 92013;
UPDATE PayFee SET amount_paid = amount_paid - 50 WHERE pay_fee_id = 2;

DELETE FROM DropCourse WHERE drop_course_id = 2;
UPDATE DropCourse SET drop_course_id = 2 WHERE drop_course_id = 3;