-- Script name: inserts.sql
-- Author: Kyle Gilbert
-- Purpose: Insert data into the database system

-- the database used to insert the data into
USE CollegeDB;

INSERT INTO School (school_id, name, address) VALUES (1, "San Francisco State University", "1600 Holloway Avenue"),
													(2, "City College of San Francisco", "50 Frida Kahlo Way"),
                                                    (3, "Cabrillo College", "6500 Soquel Dr");
                                                    
INSERT INTO Library (library_id, name, book_count, school_id) VALUES (20, "JP Library", 100, 01), 
																	(21, "Library 2", 50, 01),
                                                                    (22, "3rd Library", 75, 01);
                                                                    
INSERT INTO Book (book_id, title, author, library_id) VALUES (1, "Jonathon Livingston Seagull", "Kyle Gilbert", 20),
															(2, "Basic Calculus", "Kyle Gilbert", 20),
															(3, "Basic Physics", "Someone Else", 20),
                                                            (4, "Harry Potter", "J.K. Rowling", 20),
                                                            (5, "Book to be Deleted", "Kyle Gilbert", 20),
                                                            (6, "Book NOT at JP", "Kyle Gilbert", 21);
                                                            
INSERT INTO Student (student_id, name, grade) VALUES (92013, "Kyle Gilbert", "Senior"), (92014, "John Crooha", "Junior"),
													(92015, "Susan Watershed", "Junior"), (92016, "Yu Zhang", "Senior"),
                                                    (92017, "Ryland Denny", "Senior"), (92018, "Daniel Rodriguez", "Junior");
                        
INSERT INTO Department (department_id, name, department_chair) VALUES (4, "Computer Science", "John"), (5, "Physics", "Debbie"), 
																		(6, "English", "Bob"), (7, "Herbology", "Jenna");
        
INSERT INTO FacultyMember (faculty_id, name, department, is_chair, school_id) VALUES (1, "John Light", 4, 1, 1), (2, "Susan Connecticut", 4, 0, 1),
																					(3, "Bob Johnson", 5, 0, 1), (4, "Jen Parsley", 4, 0, 1), 
                                                                                    (5, "Jose The Third", 5, 0, 1);
        
INSERT INTO Professor (professor_id, office_hours, faculty_id) VALUES (1, "5pm-6pm", 1), (2, "10am-11am", 2), (3, "9am", 3); 
                                                    
INSERT INTO Course (course_id, title, professor, seats) VALUES (400, "Intro to Java", 1, 32), (401, "Intro to C++", 2, 32), 
																(402, "Intro to Python", 1, 32), (403, "Intermediate C++", 2, 32),
                                                                (515, "Analysis of Algorithms", 1, 32), ("415", "Operating Systems", 2, 32);

INSERT INTO Instructor (instructor_id, course) VALUES (1, 400), (2, 401), (3, 402);

INSERT INTO Enrollment (enrollment_id, student_id, course, semester, section) VALUES (1, 92013, 400, "Spring", "1"),
																						(2, 92013, 401, "Spring", "1"),
                                                                                        (3, 92014, 402, "Summer", "2"),
                                                                                        (4, 92013, 415, "Summer", "1"),
                                                                                        (5, 92015, 515, "Spring", "1"),
                                                                                        (6, 92014, 400, "Spring", "1"),
                                                                                        (7, 92015, 400, "Spring", "1");

INSERT INTO TeacherAssistant (ta_id, monthly_pay, work_hours_weekly, mentor) VALUES (1, 400, 10, 1), (2, 400, 10, 1), (3, 800, 20, 2);

INSERT INTO Researcher (researcher_id, faculty_id, num_of_grants) VALUES (1, 4, 6), (2, 1, 0), (3, 2, 4), (4, 3, 0);

INSERT INTO ResearchAssistant (research_assistant_id, work_hours_weekly, area_of_study, mentor) VALUES (1, 5, "AI", 3), (2, 10, "ML", 2), (3, 5, "AI", 3);

INSERT INTO Papers (paper_id, title) VALUES (1, "Dart vs JavaScript"), (2, "Android Obfuscation"), (3, "SQL vs NoSQL"), (4, "Test Paper");

INSERT INTO PublishPaper (publication_id, researcher, paper, conference) VALUES (1, 3, "SQL vs NoSQL", "conference test val"), 
																				(2, 3, "Dart vs JavaScript", "another conference"),
                                                                                (3, 1, "Android Obfuscation", "some conference"),
                                                                                (4, 4, "Test Paper", "test test conference");
                                                                                
INSERT INTO Grader (grader_id, instructor, student) VALUES (1, 1, 92013), (2, 2, 92013), (3, 3, 92014);
                                                                                
INSERT INTO Grade (grade_id, student, course, score) VALUES (1, 92013, 400, 95), (2, 92013, 401, 87), (3, 92014, 401, 92), (4, 92014, 400, 70),
															(5, 92015, 400, 85);

INSERT INTO PublishGrade (publish_grade_id, student, course, grader) VALUES (1, 92013, 400, 1), (2, 92013, 401, 1), (3, 92014, 402, 2);

INSERT INTO Lecturer (lecturer_id, faculty_id) VALUES (1, 1), (2, 1), (3, 2);

INSERT INTO RentBook (rent_id, student, book_id) VALUES (1, 92013, 1), (2, 92013, 4), (3, 92014, 2), (4, 92014, 3);

-- INSERT INTO FeeDue (fee_due_id, status, amount_due, student) VALUES (1, 0, 2500, 92013), (2, 0, 1000, 92014), (3, 0, 1500, 92015);

INSERT INTO PayFee (pay_fee_id, amount_paid, student) VALUES (1, 500, 92015), (2, 1000, 92016), (3, 1500, 92013);

INSERT INTO DropCourse (drop_course_id, course, student) VALUES (1, 400, 92013), (2, 401, 92013), (3, 402, 92014);