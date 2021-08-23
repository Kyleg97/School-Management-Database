-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SchoolManagementDB
-- -----------------------------------------------------
DROP DATABASE IF EXISTS CollegeDB;
CREATE DATABASE CollegeDB;
USE CollegeDB;
-- -----------------------------------------------------
-- Table `Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Student` ;

CREATE TABLE IF NOT EXISTS `Student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `grade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Course` ;

CREATE TABLE IF NOT EXISTS `Course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `professor` INT NOT NULL,
  `seats` INT NOT NULL,
  PRIMARY KEY (`course_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Enrollment` ;

CREATE TABLE IF NOT EXISTS `Enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `course` INT NOT NULL,
  `semester` VARCHAR(15) NOT NULL,
  `section` VARCHAR(45) NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `FK_ENR_STUDENT_idx` (`student_id` ASC) VISIBLE,
  INDEX `FK_ENR_COURSE_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_ENR_STUDENT`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ENR_COURSE`
    FOREIGN KEY (`course`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `School`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `School` ;

CREATE TABLE IF NOT EXISTS `School` (
  `school_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`school_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Department` ;

CREATE TABLE IF NOT EXISTS `Department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `department_chair` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FacultyMember`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FacultyMember` ;

CREATE TABLE IF NOT EXISTS `FacultyMember` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `department` INT NOT NULL,
  `is_chair` BIT(1) NOT NULL,
  `school_id` INT NOT NULL,
  PRIMARY KEY (`faculty_id`),
  INDEX `FK_FACULTY_SCHOOL_idx` (`school_id` ASC) VISIBLE,
  INDEX `FK_FACULTY_DEPARTMENT_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `FK_FACULTY_SCHOOL`
    FOREIGN KEY (`school_id`)
    REFERENCES `School` (`school_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_FACULTY_DEPARTMENT`
    FOREIGN KEY (`department`)
    REFERENCES `Department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Researcher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Researcher` ;

CREATE TABLE IF NOT EXISTS `Researcher` (
  `researcher_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_id` INT NOT NULL,
  `num_of_grants` INT NOT NULL,
  PRIMARY KEY (`researcher_id`, `faculty_id`),
  INDEX `FK_RESEARCHER_FACULTY_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `FK_RESEARCHER_FACULTY`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `FacultyMember` (`faculty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Professor` ;

CREATE TABLE IF NOT EXISTS `Professor` (
  `professor_id` INT NOT NULL,
  `office_hours` VARCHAR(45) NOT NULL,
  `course` INT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`professor_id`, `faculty_id`),
  INDEX `FK_PROFESSOR_FACULTY_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `FK_PROFESSOR_FACULTY`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `FacultyMember` (`faculty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PROFESSOR_COURSE`
    FOREIGN KEY (`course`)
    REFERENCES `Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Lecturer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Lecturer` ;

CREATE TABLE IF NOT EXISTS `Lecturer` (
  `lecturer_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`lecturer_id`, `faculty_id`),
  INDEX `FK_LECTURER_FACULTY_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `FK_LECTURER_FACULTY`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `FacultyMember` (`faculty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Papers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Papers` ;

CREATE TABLE IF NOT EXISTS `Papers` (
  `paper_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paper_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PublishPaper`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PublishPaper` ;

CREATE TABLE IF NOT EXISTS `PublishPaper` (
  `publication_id` INT NOT NULL,
  `researcher` INT NOT NULL,
  `paper` VARCHAR(45) NOT NULL,
  `conference` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`publication_id`),
  INDEX `FK_PUB_RESEARCHER_idx` (`researcher` ASC) VISIBLE,
  CONSTRAINT `FK_PUB_RESEARCHER`
    FOREIGN KEY (`researcher`)
    REFERENCES `Researcher` (`researcher_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PUB_PAPER`
    FOREIGN KEY (`publication_id`)
    REFERENCES `Papers` (`paper_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Instructor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Instructor` ;

CREATE TABLE IF NOT EXISTS `Instructor` (
  `instructor_id` INT NOT NULL,
  `course` INT NULL,
  PRIMARY KEY (`instructor_id`),
  INDEX `FK_INSTRUCTOR_COURSE_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_INSTRUCTOR_FACULTY`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `FacultyMember` (`faculty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_INSTRUCTOR_COURSE`
    FOREIGN KEY (`course`)
    REFERENCES `Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library` ;

CREATE TABLE IF NOT EXISTS `Library` (
  `library_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `book_count` INT NOT NULL,
  `school_id` INT NOT NULL,
  PRIMARY KEY (`library_id`),
  INDEX `FK_LIBRARY_SCHOOL_idx` (`school_id` ASC) VISIBLE,
  CONSTRAINT `FK_LIBRARY_SCHOOL`
    FOREIGN KEY (`school_id`)
    REFERENCES `School` (`school_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Book` ;

CREATE TABLE IF NOT EXISTS `Book` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `author` VARCHAR(100) NOT NULL,
  `library_id` INT NULL,
  PRIMARY KEY (`book_id`, `title`),
  INDEX `FK_BOOK_LIBRARY_idx` (`library_id` ASC) VISIBLE,
  CONSTRAINT `FK_BOOK_LIBRARY`
    FOREIGN KEY (`library_id`)
    REFERENCES `Library` (`library_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RentBook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RentBook` ;

CREATE TABLE IF NOT EXISTS `RentBook` (
  `rent_id` INT NOT NULL AUTO_INCREMENT,
  `student` INT NULL,
  `book_id` INT NULL,
  PRIMARY KEY (`rent_id`),
  INDEX `FK_BOOK_STUDENT_idx` (`student` ASC) VISIBLE,
  INDEX `FK_RENT_BOOK_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `FK_RENT_STUDENT`
    FOREIGN KEY (`student`)
    REFERENCES `Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_RENT_BOOK`
    FOREIGN KEY (`book_id`)
    REFERENCES `Book` (`book_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DropStudent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DropStudent` ;

CREATE TABLE IF NOT EXISTS `DropStudent` (
  `drop_student_id` INT NOT NULL AUTO_INCREMENT,
  `student` INT NOT NULL,
  `instructor` INT NULL,
  `course` INT NOT NULL,
  `reason` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`drop_student_id`),
  INDEX `FK_DROPSTUDENT_INSTRUCTOR_idx` (`instructor` ASC) VISIBLE,
  INDEX `FK_DROPSTUDENT_COURSE_idx` (`course` ASC) VISIBLE,
  INDEX `FK_DROPSTUDENT_STUDENT_idx` (`student` ASC) VISIBLE,
  CONSTRAINT `FK_DROPSTUDENT_STUDENT`
    FOREIGN KEY (`student`)
    REFERENCES `Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_DROPSTUDENT_INSTRUCTOR`
    FOREIGN KEY (`instructor`)
    REFERENCES `Instructor` (`instructor_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_DROPSTUDENT_COURSE`
    FOREIGN KEY (`course`)
    REFERENCES `Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DropCourse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DropCourse` ;

CREATE TABLE IF NOT EXISTS `DropCourse` (
  `drop_course_id` INT NOT NULL AUTO_INCREMENT,
  `course` INT NOT NULL,
  `student` INT NOT NULL,
  PRIMARY KEY (`drop_course_id`),
  INDEX `FK_DROPCOURSE_STUDENT_idx` (`student` ASC) VISIBLE,
  INDEX `FK_DROPCOURSE_COURSE_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_DROPCOURSE_STUDENT`
    FOREIGN KEY (`student`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_DROPCOURSE_COURSE`
    FOREIGN KEY (`course`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ResearchAssistant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ResearchAssistant` ;

CREATE TABLE IF NOT EXISTS `ResearchAssistant` (
  `research_assistant_id` INT NOT NULL AUTO_INCREMENT,
  `work_hours_weekly` INT NOT NULL,
  `area_of_study` VARCHAR(45) NOT NULL,
  `mentor` INT NULL,
  PRIMARY KEY (`research_assistant_id`),
  INDEX `FK_RA_MENTOR_idx` (`mentor` ASC) VISIBLE,
  CONSTRAINT `FK_RA_MENTOR`
    FOREIGN KEY (`mentor`)
    REFERENCES `Researcher` (`researcher_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TeacherAssistant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TeacherAssistant` ;

CREATE TABLE IF NOT EXISTS `TeacherAssistant` (
  `ta_id` INT NOT NULL AUTO_INCREMENT,
  `monthly_pay` INT NOT NULL,
  `work_hours_weekly` INT NOT NULL,
  `mentor` INT NULL,
  PRIMARY KEY (`ta_id`),
  INDEX `FK_TA_MENTOR_idx` (`mentor` ASC) VISIBLE,
  CONSTRAINT `FK_TA_MENTOR`
    FOREIGN KEY (`mentor`)
    REFERENCES `Instructor` (`instructor_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Grader`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Grader` ;

CREATE TABLE IF NOT EXISTS `Grader` (
  `grader_id` INT NOT NULL AUTO_INCREMENT,
  `instructor` INT NULL,
  `student` INT NULL,
  PRIMARY KEY (`grader_id`),
  INDEX `FK_GRADER_INSTRUCTOR_idx` (`instructor` ASC) VISIBLE,
  INDEX `FK_GRADER_STUDENT_idx` (`student` ASC) VISIBLE,
  CONSTRAINT `FK_GRADER_INSTRUCTOR`
    FOREIGN KEY (`instructor`)
    REFERENCES `Instructor` (`instructor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_GRADER_STUDENT`
    FOREIGN KEY (`student`)
    REFERENCES `Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Grade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Grade` ;

CREATE TABLE IF NOT EXISTS `Grade` (
  `grade_id` INT NOT NULL AUTO_INCREMENT,
  `student` INT NOT NULL,
  `course` INT NOT NULL,
  `score` INT NOT NULL,
  PRIMARY KEY (`grade_id`),
  INDEX `FK_GRADE_STUDENT_idx` (`student` ASC) VISIBLE,
  INDEX `FK_GRADE_COURSE_idx` (`course` ASC) VISIBLE,
  CONSTRAINT `FK_GRADE_STUDENT`
    FOREIGN KEY (`student`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_GRADE_COURSE`
    FOREIGN KEY (`course`)
    REFERENCES `Course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PublishGrade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PublishGrade` ;

CREATE TABLE IF NOT EXISTS `PublishGrade` (
  `publish_grade_id` INT NOT NULL AUTO_INCREMENT,
  `student` INT NOT NULL,
  `course` INT NOT NULL,
  `grader` INT NOT NULL,
  PRIMARY KEY (`publish_grade_id`),
  INDEX `FK_PUBLISH_STUDENT_idx` (`student` ASC) VISIBLE,
  INDEX `FK_PUBLISH_COURSE_idx` (`course` ASC) VISIBLE,
  INDEX `FK_PUBLISH_GRADER_idx` (`grader` ASC) VISIBLE,
  CONSTRAINT `FK_PUBLISH_STUDENT`
    FOREIGN KEY (`student`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PUBLISH_COURSE`
    FOREIGN KEY (`course`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PUBLISH_GRADER`
    FOREIGN KEY (`grader`)
    REFERENCES `Grader` (`grader_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FeeDue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FeeDue` ;

CREATE TABLE IF NOT EXISTS `FeeDue` (
  `fee_due_id` INT NOT NULL AUTO_INCREMENT,
  `status` BIT(1) NOT NULL,
  `amount_due` INT NOT NULL,
  `student` INT NOT NULL,
  PRIMARY KEY (`fee_due_id`),
  INDEX `FK_FEEDUE_STUDENT_idx` (`amount_due` ASC) VISIBLE,
  CONSTRAINT `FK_FEEDUE_STUDENT`
    FOREIGN KEY (`amount_due`)
    REFERENCES `Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PayFee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PayFee` ;

CREATE TABLE IF NOT EXISTS `PayFee` (
  `pay_fee_id` INT NOT NULL AUTO_INCREMENT,
  `amount_paid` INT NOT NULL,
  `student` INT NOT NULL,
  PRIMARY KEY (`pay_fee_id`),
  INDEX `FK_PAYFEE_STUDENT_idx` (`student` ASC) VISIBLE,
  CONSTRAINT `FK_PAYFEE_STUDENT`
    FOREIGN KEY (`student`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

#INSERT INTO Library (name, book_count, school_id) VALUES (1, "libraryname", 0, 1);
#INSERT INTO Book (title, author) VALUES ("book1", "kyle"), ("book2", "john");

#INSERT INTO Enrollment (enrollment_id, student_id, course, semester, section) VALUES (1, 92000, 675, "Summer", "1");

DELIMITER //
CREATE TRIGGER UpdateLibrary AFTER INSERT ON Book
FOR EACH ROW
	BEGIN
		UPDATE Library SET book_count = book_count + 1 WHERE library_id = NEW.library_id;
    END;//
DELIMITER ;

DELIMITER //
CREATE TRIGGER UpdateCourseSeats AFTER INSERT ON Enrollment
FOR EACH ROW
	BEGIN
		UPDATE Course SET seats = seats - 1 WHERE course_id = NEW.course; 
    END;//
DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
