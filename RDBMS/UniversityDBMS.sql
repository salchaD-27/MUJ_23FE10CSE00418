--Creating Tables
CREATE TABLE University_Faculties (Faculty_ID VARCHAR2(50) PRIMARY KEY, Faculty_Email VARCHAR2(100), First_Name VARCHAR2(100), Last_Name VARCHAR2(100), Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')), Hire_Date DATE, 
    Contact_Number NUMBER, Designation VARCHAR2(100) CHECK (Designation IN ('Dr', 'Prof', 'Mr', 'Mrs', 'Ms')), Salary NUMBER);
CREATE TABLE University_Departments (Dept_ID VARCHAR2(100) PRIMARY KEY, Dept_Name VARCHAR2(100), Dept_HOD VARCHAR2(100), Faculty_ID VARCHAR2(50));
CREATE TABLE University_Courses (Course_ID VARCHAR2(50) PRIMARY KEY, Course_Name VARCHAR2(100), Course_Credits NUMBER, Course_Duration NUMBER, Dept_ID VARCHAR2(50));
CREATE TABLE University_Subjects (Subject_ID VARCHAR2(50) PRIMARY KEY, Subject_Name VARCHAR2(100), Subject_Credits NUMBER, Subject_Coordinator VARCHAR2(50), Course_ID VARCHAR2(50), Faculty_ID VARCHAR2(50));
CREATE TABLE University_Sections (Section_ID VARCHAR2(50) PRIMARY KEY, Section_Name VARCHAR2(100), Section_Coordinator VARCHAR2(100), Section_Room VARCHAR2(255), Section_Strength NUMBER, Faculty_ID VARCHAR2(50));
CREATE TABLE University_Exams (Exam_ID VARCHAR2(50) PRIMARY KEY, Exam_Type VARCHAR2(50), Exam_Date DATE, Maximum_Marks NUMBER, Subject_ID VARCHAR2(50));
CREATE TABLE University_Hostels (Hostel_ID VARCHAR2(50) PRIMARY KEY, Hostel_Name VARCHAR2(100), Hostel_Capacity NUMBER, Warden_ID VARCHAR2(50));
CREATE TABLE University_Students (Student_ID VARCHAR2(50) PRIMARY KEY, Student_Email VARCHAR2(100), First_Name VARCHAR2(100), Last_Name VARCHAR2(100), Father_Name VARCHAR2(100), DOB DATE, 
    Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')), Contact_Number NUMBER, Address VARCHAR2(255), Blood_Group VARCHAR2(3) CHECK (Blood_Group IN ('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')), 
    Year_Enrolled NUMBER, Section_ID VARCHAR2(50), Hostel_ID VARCHAR2(50));
CREATE TABLE University_Results (Result_ID VARCHAR2(50) PRIMARY KEY, Marks_Obtained NUMBER, Grade VARCHAR2(2) CHECK (Gender IN ('A+', 'A', 'B', 'C', 'D', 'E', 'F')), Faculty_ID VARCHAR2(50), Student_ID VARCHAR2(50));
CREATE TABLE University_Hostel_Allotment (Allotment_ID VARCHAR2(50) PRIMARY KEY, Room_Number VARCHAR2(10), Room_Type VARCHAR2(50), Allotment_Date DATE, Student_ID VARCHAR2(50), Hostel_ID VARCHAR2(50));
CREATE TABLE University_Library (Book_ID VARCHAR2(50) PRIMARY KEY, Title VARCHAR2(255), Author VARCHAR2(255), Publication_Year NUMBER, Available_Copies NUMBER);
CREATE TABLE University_Borrowed_Books (Borrow_ID VARCHAR2(50) PRIMARY KEY, Issue_Date DATE, Return_Date DATE, Book_ID VARCHAR2(50), Student_ID VARCHAR2(50));

--Adding Foreign Key Constraints
ALTER TABLE University_Students ADD CONSTRAINT AssignedToFK FOREIGN KEY (Section_ID) REFERENCES University_Sections(Section_ID);
ALTER TABLE University_Students ADD CONSTRAINT ResidesInFK FOREIGN KEY (Hostel_ID) REFERENCES University_Hostels(Hostel_ID);
ALTER TABLE University_Departments ADD CONSTRAINT SupervisedByFK FOREIGN KEY (Faculty_ID) REFERENCES University_Faculties(Faculty_ID);
ALTER TABLE University_Courses ADD CONSTRAINT OffersFK FOREIGN KEY (Dept_ID) REFERENCES University_Departments(Dept_ID);
ALTER TABLE University_Subjects ADD CONSTRAINT ContainsFK FOREIGN KEY (Course_ID) REFERENCES University_Courses(Course_ID);
ALTER TABLE University_Subjects ADD CONSTRAINT TeachesFK FOREIGN KEY (Faculty_ID) REFERENCES University_Faculties(Faculty_ID);
ALTER TABLE University_Sections ADD CONSTRAINT ControlledByFK FOREIGN KEY (Faculty_ID) REFERENCES University_Faculties(Faculty_ID);
ALTER TABLE University_Exams ADD CONSTRAINT OfSubjectFK FOREIGN KEY (Subject_ID) REFERENCES University_Subjects(Subject_ID);
ALTER TABLE University_Results ADD CONSTRAINT GeneratesFK FOREIGN KEY (Faculty_ID) REFERENCES University_Faculties(Faculty_ID);
ALTER TABLE University_Results ADD CONSTRAINT ScoresFK FOREIGN KEY (Student_ID) REFERENCES University_Students(Student_ID);
ALTER TABLE University_Hostel_Allotment ADD CONSTRAINT AllotmentFK FOREIGN KEY (Student_ID) REFERENCES University_Students(Student_ID);
ALTER TABLE University_Hostel_Allotment ADD CONSTRAINT AllotsFK FOREIGN KEY (Hostel_ID) REFERENCES University_Hostels(Hostel_ID);
ALTER TABLE University_Borrowed_Books ADD CONSTRAINT HoldsFK FOREIGN KEY (Book_ID) REFERENCES University_Library(Book_ID);
ALTER TABLE University_Borrowed_Books ADD CONSTRAINT BorrowsFK FOREIGN KEY (Student_ID) REFERENCES University_Students(Student_ID);

--Creating Tables for Relationships and Special Attributes
CREATE TABLE University_Enrolls (Student_ID, Course_ID, 
    CONSTRAINT ESIFK FOREIGN KEY (Student_ID) REFERENCES University_Students(Student_ID),
    CONSTRAINT ECIFK FOREIGN KEY (Course_ID) REFERENCES University_Courses(Course_ID));
CREATE TABLE University_Taught_In (Subject_ID, Section_ID,
    CONSTRAINT TISbIFK FOREIGN KEY (Subject_ID) REFERENCES University_Subjects(Subject_ID),
    CONSTRAINT TIScIFK FOREIGN KEY (Section_ID) REFERENCES University_Sections(Section_ID));
CREATE TABLE University_Borrows (Student_ID, Borrow_ID,
    CONSTRAINT BSIFK FOREIGN KEY (Student_ID) REFERENCES University_Students(Student_ID),
    CONSTRAINT BBIFK FOREIGN KEY (Borrow_ID) REFERENCES University_Borrowed_Books(Borrow_ID));
CREATE TABLE University_Attempts (Student_ID, Exam_ID,
    CONSTRAINT ASIFK FOREIGN KEY (Student_ID) REFERENCES University_Students(Student_ID),
    CONSTRAINT AEIFK FOREIGN KEY (Exam_ID) REFERENCES University_Exams(Exam_ID));
CREATE TABLE University_Dept_Courses_List (Dept_ID, Dept_Courses,
    CONSTRAINT DCLDIFK FOREIGN KEY (Dept_ID) REFERENCES University_Departments(Dept_ID));

--Backup Commands to Drop Constraints
ALTER TABLE University_Student DROP CONSTRAINT AssignedToFK;
ALTER TABLE University_Student DROP CONSTRAINT ResidesInFK;
ALTER TABLE University_Departments DROP CONSTRAINT SupervisedByFK;
ALTER TABLE University_Courses DROP CONSTRAINT OffersFK;
ALTER TABLE University_Subjects DROP CONSTRAINT ContainsFK;
ALTER TABLE University_Subjects DROP CONSTRAINT TeachesFK;
ALTER TABLE University_Sections DROP CONSTRAINT ControlledByFK;
ALTER TABLE University_Exams DROP CONSTRAINT AssessesFK;
ALTER TABLE University_Results DROP CONSTRAINT GeneratesFK;
ALTER TABLE University_Results DROP CONSTRAINT ScoresFK;
ALTER TABLE University_Hostel_Allotment DROP CONSTRAINT AllotmentFK;
ALTER TABLE University_Hostel_Allotment DROP CONSTRAINT AllotsFK;
ALTER TABLE University_Borrowed_Books DROP CONSTRAINT HoldsFK;
ALTER TABLE University_Borrowed_Books DROP CONSTRAINT BorrowsFK;
ALTER TABLE University_Enrolls DROP CONSTRAINT ESIFK;
ALTER TABLE University_Enrolls DROP CONSTRAINT ECIFK;
ALTER TABLE University_Taught_In DROP CONSTRAINT TISbIFK;
ALTER TABLE University_Taught_In DROP CONSTRAINT TIScIFK;
ALTER TABLE University_Borrows DROP CONSTRAINT BSIFK;
ALTER TABLE University_Borrows DROP CONSTRAINT BBIFK;
ALTER TABLE University_Attempts DROP CONSTRAINT ASIFK;
ALTER TABLE University_Attempts DROP CONSTRAINT AEIFK;
ALTER TABLE University_Dept_Courses_List DROP CONSTRAINT DCLDIFK;

--Backup Commands to Drop Tables
DROP TABLE University_Students;
DROP TABLE University_Departments;
DROP TABLE University_Courses;
DROP TABLE University_Subjects;
DROP TABLE University_Sections;
DROP TABLE University_Faculties;
DROP TABLE University_Exams;
DROP TABLE University_Results;
DROP TABLE University_Hostels;
DROP TABLE University_Hostel_Allotment;
DROP TABLE University_Library;
DROP TABLE University_Borrowed_Books;
DROP TABLE University_Enrolls;
DROP TABLE University_Taught_In;
DROP TABLE University_Borrows;
DROP TABLE University_Attempts;
DROP TABLE University_Dept_Courses_List;

--Creating Triggers
CREATE OR REPLACE TRIGGER trg_generate_student_id_email
BEFORE INSERT ON University_Students
FOR EACH ROW
DECLARE
    v_year_part VARCHAR2(2);
    v_dob_part VARCHAR2(6);
    v_section_id VARCHAR2(50);
BEGIN
    v_year_part := SUBSTR(TO_CHAR(:NEW.Year_Enrolled), -2);
    v_dob_part := TO_CHAR(:NEW.DOB, 'DDMMYY');
    v_section_id := NVL(:NEW.Section_ID, '');
    :NEW.Student_ID := v_year_part || v_section_id || SUBSTR(:NEW.First_Name, 1, 2) || SUBSTR(:NEW.Last_Name, 1, 2) || v_dob_part || :NEW.Gender;
    :NEW.Student_Email := LOWER(:NEW.First_Name || '_' || :NEW.Last_Name || '.' || :NEW.Student_ID || '@student.univ.edu');
END;
/
CREATE OR REPLACE TRIGGER trg_generate_faculty_id_email
BEFORE INSERT ON University_Faculties
FOR EACH ROW
DECLARE
    v_year_part VARCHAR2(2); 
    v_salary_digits NUMBER; 
    v_salary_part VARCHAR2(2); 
BEGIN
    v_year_part := SUBSTR(TO_CHAR(:NEW.Hire_Date, 'YYYY'), -2);
    v_salary_part := SUBSTR(TO_CHAR(:NEW.Salary), 1, 2);
    v_salary_digits := LENGTH(TO_CHAR(:NEW.Salary));
    :NEW.Faculty_ID := v_year_part || LOWER(:NEW.Designation) || SUBSTR(:NEW.First_Name, 1, 2) || SUBSTR(:NEW.Last_Name, 1, 2) || v_salary_part || v_salary_digits || :NEW.Gender;
    :NEW.Faculty_Email := LOWER(:NEW.First_Name || '_' || :NEW.Last_Name || '.' || :NEW.Faculty_ID || '@faculty.univ.edu');
END;
/
CREATE OR REPLACE TRIGGER trg_generate_department_id
BEFORE INSERT ON University_Departments
FOR EACH ROW
DECLARE
    v_department_acronym VARCHAR2(50);
    v_is_new_word BOOLEAN := TRUE;
BEGIN
    v_department_acronym := '';
    FOR i IN 1 .. LENGTH(:NEW.Dept_Name) LOOP
        IF v_is_new_word THEN
            v_department_acronym := v_department_acronym || SUBSTR(:NEW.Dept_Name, i, 1);
            v_is_new_word := FALSE;
        END IF;
        IF SUBSTR(:NEW.Dept_Name, i, 1) = ' ' THEN
            v_is_new_word := TRUE;
        END IF;
    END LOOP;
    :NEW.Dept_ID := v_department_acronym;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_course_id
BEFORE INSERT ON University_Courses
FOR EACH ROW
DECLARE
    v_course_acronym VARCHAR2(50);
    v_is_new_word BOOLEAN := TRUE;
BEGIN
    v_course_acronym := '';
    FOR i IN 1 .. LENGTH(:NEW.Course_Name) LOOP
        IF v_is_new_word THEN
            v_course_acronym := v_course_acronym || SUBSTR(:NEW.Course_Name, i, 1);
            v_is_new_word := FALSE;
        END IF;
        IF SUBSTR(:NEW.Course_Name, i, 1) = ' ' THEN
            v_is_new_word := TRUE;
        END IF;
    END LOOP;
    :NEW.Course_ID := :NEW.Course_Duration || v_course_acronym || :NEW.Course_Credits || :NEW.Dept_ID;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_subject_id
BEFORE INSERT ON University_Subjects
FOR EACH ROW
DECLARE
    v_subject_name_abbr VARCHAR2(50);
    v_is_new_word BOOLEAN := TRUE;
BEGIN
    v_subject_name_abbr := '';
    FOR i IN 1 .. LENGTH(:NEW.Subject_Name) LOOP
        IF v_is_new_word THEN
            v_subject_name_abbr := v_subject_name_abbr || SUBSTR(:NEW.Subject_Name, i, 2);
            v_is_new_word := FALSE;
        END IF;
        IF SUBSTR(:NEW.Subject_Name, i, 1) = ' ' THEN
            v_is_new_word := TRUE;
        END IF;
    END LOOP;
    :NEW.Subject_ID := v_subject_name_abbr || :NEW.Subject_Credits || :NEW.Course_ID;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_section_id
BEFORE INSERT ON University_Sections
FOR EACH ROW
DECLARE
    v_coordinator_abbr VARCHAR2(50);
    v_is_new_word BOOLEAN := TRUE;
BEGIN
    v_coordinator_abbr := '';
    FOR i IN 1 .. LENGTH(:NEW.Section_Coordinator) LOOP
        IF v_is_new_word THEN
            v_coordinator_abbr := v_coordinator_abbr || SUBSTR(:NEW.Section_Coordinator, i, 2);
            v_is_new_word := FALSE;
        END IF;
        IF SUBSTR(:NEW.Section_Coordinator, i, 1) = ' ' THEN
            v_is_new_word := TRUE; 
        END IF;
    END LOOP;
    :NEW.Section_ID := :NEW.Section_Name || :NEW.Section_Strength || v_coordinator_abbr || :NEW.Section_Room;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_exam_id
BEFORE INSERT ON University_Exams
FOR EACH ROW
BEGIN
    DECLARE
        v_exam_type_char CHAR(1);
        v_exam_date_char VARCHAR2(6);
    BEGIN
        v_exam_type_char := SUBSTR(:NEW.Exam_Type, 1, 1);
        v_exam_date_char := TO_CHAR(:NEW.Exam_Date, 'DDMMYY');
        :NEW.Exam_ID := v_exam_type_char || :NEW.Maximum_Marks || v_exam_date_char || :NEW.Subject_ID;
    END;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_hostel_id
BEFORE INSERT ON University_Hostels
FOR EACH ROW
DECLARE
    v_hostel_name_abbr VARCHAR2(50);
BEGIN
    v_hostel_name_abbr := REGEXP_REPLACE(:NEW.Hostel_Name, '\b(\w)\w*', '\1');
    :NEW.Hostel_ID := v_hostel_name_abbr || :NEW.Hostel_Capacity || :NEW.Warden_ID;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_result_id
BEFORE INSERT ON University_Results
FOR EACH ROW
BEGIN
    :NEW.Result_ID := :NEW.Student_ID || ':_:' || :NEW.Faculty_ID || ':_:' || :NEW.Marks_Obtained || :NEW.Grade;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_allotment_id
BEFORE INSERT ON University_Hostel_Allotment
FOR EACH ROW
DECLARE
    v_allotment_id VARCHAR2(50);
BEGIN
    v_allotment_id := :NEW.Room_Number || :NEW.Room_Type || TO_CHAR(:NEW.Allotment_Date, 'DDMMYY') || :NEW.Student_ID;
    :NEW.Allotment_ID := v_allotment_id;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_book_id
BEFORE INSERT ON University_Library
FOR EACH ROW
DECLARE
    v_title_part VARCHAR2(50) := '';
    v_author_part VARCHAR2(50) := '';
    v_year_part VARCHAR2(2);
    word VARCHAR2(50);
BEGIN
    FOR i IN 1..REGEXP_COUNT(:NEW.Title, '[^ ]+') LOOP
        word := REGEXP_SUBSTR(:NEW.Title, '[^ ]+', 1, i);
        v_title_part := v_title_part || SUBSTR(UPPER(word), 1, 1);
    END LOOP;
    FOR i IN 1..REGEXP_COUNT(:NEW.Author, '[^ ]+') LOOP
        word := REGEXP_SUBSTR(:NEW.Author, '[^ ]+', 1, i);
        v_author_part := v_author_part || SUBSTR(UPPER(word), 1, 2);
    END LOOP;
    v_year_part := TO_CHAR(MOD(:NEW.Publication_Year, 100), 'FM00');
    :NEW.Book_ID := v_title_part || v_author_part || v_year_part;
END;
/
CREATE OR REPLACE TRIGGER trg_generate_borrow_id
BEFORE INSERT ON University_Borrowed_Books
FOR EACH ROW
DECLARE
    v_issue_date VARCHAR2(8);
    v_return_date VARCHAR2(8);
BEGIN
    v_issue_date := TO_CHAR(:NEW.Issue_Date, 'DDMMYY');
    v_return_date := TO_CHAR(:NEW.Return_Date, 'DDMMYY');
    :NEW.Borrow_ID := :NEW.Book_ID || v_issue_date || ':-:' || v_return_date;
END;
/
CREATE OR REPLACE TRIGGER trg_decrease_available_copies
AFTER INSERT ON University_Borrowed_Books
FOR EACH ROW
BEGIN
    UPDATE University_Library
    SET Available_Copies = Available_Copies - 1
    WHERE Book_ID = :NEW.Book_ID;
END;
/
CREATE OR REPLACE TRIGGER trg_increase_available_copies
AFTER DELETE ON University_Borrowed_Books
FOR EACH ROW
BEGIN
    UPDATE University_Library
    SET Available_Copies = Available_Copies + 1
    WHERE Book_ID = :OLD.Book_ID;
END;
/
BEGIN
   FOR trg IN (SELECT trigger_name FROM user_triggers) LOOP
      EXECUTE IMMEDIATE 'DROP TRIGGER ' || trg.trigger_name;
   END LOOP;
END;
/

--Inserting Values intro Tables
INSERT INTO University_Faculties (First_Name, Last_Name, Gender, Hire_Date, Contact_Number, Designation, Salary)
SELECT 'Alice', 'Johnson', 'F', TO_DATE('2010-08-01', 'YYYY-MM-DD'), 9876543210, 'Prof', 95000 FROM dual
UNION ALL SELECT 'Brian', 'Smith', 'M', TO_DATE('2015-01-10', 'YYYY-MM-DD'), 9876543211, 'Dr', 92000 FROM dual
UNION ALL SELECT 'Carol', 'Williams', 'F', TO_DATE('2018-09-15', 'YYYY-MM-DD'), 9876543212, 'Prof', 90000 FROM dual
UNION ALL SELECT 'David', 'Brown', 'M', TO_DATE('2019-02-20', 'YYYY-MM-DD'), 9876543213, 'Mr', 91000 FROM dual
UNION ALL SELECT 'Emma', 'Davis', 'F', TO_DATE('2012-04-30', 'YYYY-MM-DD'), 9876543214, 'Ms', 88000 FROM dual
UNION ALL SELECT 'Fiona', 'Garcia', 'F', TO_DATE('2011-03-25', 'YYYY-MM-DD'), 9876543215, 'Prof', 85000 FROM dual
UNION ALL SELECT 'George', 'Martinez','M', TO_DATE('2013-05-18', 'YYYY-MM-DD'), 9876543216, 'Dr', 95000 FROM dual
UNION ALL SELECT 'Hannah', 'Wilson','F', TO_DATE('2014-02-15', 'YYYY-MM-DD'), 9876543217, 'Ms', 87000 FROM dual
UNION ALL SELECT 'Ian', 'Thompson','M', TO_DATE('2020-09-30', 'YYYY-MM-DD'), 9876543218, 'Mr', 64000 FROM dual
UNION ALL SELECT 'Jessica', 'Clark', 'F', TO_DATE('2020-01-12', 'YYYY-MM-DD'), 9876543219, 'Prof', 92000 FROM dual
UNION ALL SELECT 'Kathy', 'Morris', 'F', TO_DATE('2016-06-15', 'YYYY-MM-DD'), 9876543220, 'Dr', 88000 FROM dual
UNION ALL SELECT 'Larry', 'White', 'M', TO_DATE('2019-01-10', 'YYYY-MM-DD'), 9876543221, 'Mr', 65000 FROM dual
UNION ALL SELECT 'Michael', 'Jones', 'M', TO_DATE('2013-04-01', 'YYYY-MM-DD'), 9876543222, 'Prof', 85000 FROM dual
UNION ALL SELECT 'Nina', 'Taylor', 'F', TO_DATE('2020-08-22', 'YYYY-MM-DD'), 9876543223, 'Ms', 61000 FROM dual
UNION ALL SELECT 'Oscar', 'Martin', 'M', TO_DATE('2012-03-15', 'YYYY-MM-DD'), 9876543224, 'Dr', 87000 FROM dual
UNION ALL SELECT 'Paul', 'Hernandez', 'M', TO_DATE('2014-12-30', 'YYYY-MM-DD'), 9876543225, 'Mr', 63000 FROM dual
UNION ALL SELECT 'Quinn', 'Scott', 'F', TO_DATE('2020-09-30', 'YYYY-MM-DD'), 9876543226, 'Prof', 82000 FROM dual
UNION ALL SELECT 'Rick', 'Robinson', 'M', TO_DATE('2011-05-05', 'YYYY-MM-DD'), 9876543227, 'Dr', 84000 FROM dual
UNION ALL SELECT 'Sara', 'Adams', 'F', TO_DATE('2019-02-12', 'YYYY-MM-DD'), 9876543228, 'Ms', 60000 FROM dual
UNION ALL SELECT 'Tom', 'Harris', 'M', TO_DATE('2013-10-12', 'YYYY-MM-DD'), 9876543229, 'Prof', 86000 FROM dual
UNION ALL SELECT 'Uma', 'Roberts', 'F', TO_DATE('2021-01-15', 'YYYY-MM-DD'), 9876543230, 'Mrs', 62000 FROM dual
UNION ALL SELECT 'Vera', 'Baker','F', TO_DATE('2018-05-30', 'YYYY-MM-DD'), 9876543231, 'Prof', 84000 FROM dual
UNION ALL SELECT 'Walter', 'Cruz','M', TO_DATE('2020-06-20', 'YYYY-MM-DD'), 9876543232, 'Mr', 61000 FROM dual
UNION ALL SELECT 'Xena', 'Nelson','F', TO_DATE('2014-10-14', 'YYYY-MM-DD'), 9876543233, 'Dr', 83000 FROM dual
UNION ALL SELECT 'Yves', 'Foster','M', TO_DATE('2012-09-21', 'YYYY-MM-DD'), 9876543234, 'Mr', 88000 FROM dual
UNION ALL SELECT 'Zara', 'Cook','F', TO_DATE('2020-02-28', 'YYYY-MM-DD'), 9876543235, 'Ms', 60000 FROM dual
UNION ALL SELECT 'Adam', 'Ward', 'M', TO_DATE('2014-03-20', 'YYYY-MM-DD'), 9876543236, 'Prof', 85000 FROM dual
UNION ALL SELECT 'Betty', 'Evans', 'F', TO_DATE('2019-11-01', 'YYYY-MM-DD'), 9876543237, 'Mrs', 62000 FROM dual;
SELECT * FROM University_Faculties
TRUNCATE TABLE University_Faculties

INSERT INTO University_Departments (Dept_Name, Dept_HOD, Faculty_ID)
SELECT 'Department of Computer Science Engineering', 'Prof Alice Johnson', '10profAlJo955F' FROM dual
UNION ALL SELECT 'Department of Electrical Engineering', 'Dr Brian Smith', '15drBrSm925M' FROM dual
UNION ALL SELECT 'Department of Mechanical Engineering', 'Prof Carol Williams', '18profCaWi905F' FROM dual
UNION ALL SELECT 'Department of Civil Engineering', 'Mr David Brown', '19mrDaBr915M' FROM dual
UNION ALL SELECT 'Department of Business Administration', 'Ms Emma Davis', '12msEmDa885F' FROM dual
UNION ALL SELECT 'Department of Biotechnology', 'Prof Fiona Garcia', '11profFiGa855F' FROM dual
UNION ALL SELECT 'Department of Mathematics', 'Dr George Martinez', '13drGeMa955M' FROM dual
UNION ALL SELECT 'Department of Physics', 'Ms Hannah Wilson', '14msHaWi875F' FROM dual
UNION ALL SELECT 'Department of Chemistry', 'Mr Ian Thompson', '20mrIaTh645M' FROM dual
UNION ALL SELECT 'Department of Environmental Science', 'Prof Jessica Clark', '20profJeCl925F' FROM dual;
SELECT * FROM University_Departments
TRUNCATE TABLE University_Departments

INSERT INTO University_Courses (Course_Name, Course_Credits, Course_Duration, Dept_ID)
SELECT 'Bachelor of Technology in Computer Science', 96, 4, 'DoCSE' FROM dual
UNION ALL SELECT 'Bachelor of Technology in Data Science', 96, 4, 'DoCSE' FROM dual
UNION ALL SELECT 'Master of Technology in Computer Science', 48, 2, 'DoCSE' FROM dual
UNION ALL SELECT 'Bachelor of Technology in Electrical Engineering', 96, 4, 'DoEE' FROM dual
UNION ALL SELECT 'Master of Technology in Electrical Engineering', 48, 2, 'DoEE' FROM dual
UNION ALL SELECT 'Bachelor of Technology in Mechanical Engineering', 96, 4, 'DoME' FROM dual
UNION ALL SELECT 'Master of Technology in Mechanical Engineering', 48, 2, 'DoME' FROM dual
UNION ALL SELECT 'Bachelor of Technology in Civil Engineering', 96, 4, 'DoCE' FROM dual
UNION ALL SELECT 'Master of Technology in Civil Engineering', 48, 2, 'DoCE' FROM dual
UNION ALL SELECT 'Diploma in Civil Engineering', 66, 3, 'DoCE' FROM dual
UNION ALL SELECT 'Bachelor of Business Administration', 66, 3, 'DoBA' FROM dual
UNION ALL SELECT 'Master of Business Administration', 48, 2, 'DoBA' FROM dual
UNION ALL SELECT 'Bachelor of Science in Biotechnology', 66, 3, 'DoB' FROM dual
UNION ALL SELECT 'Master of Science in Biotechnology', 48, 2, 'DoB' FROM dual
UNION ALL SELECT 'Bachelor of Science in Mathematics', 66, 3, 'DoM' FROM dual
UNION ALL SELECT 'Master of Science in Mathematics', 48, 2, 'DoM' FROM dual
UNION ALL SELECT 'Bachelor of Science in Physics', 66, 3, 'DoP' FROM dual
UNION ALL SELECT 'Master of Science in Physics', 48, 2, 'DoP' FROM dual
UNION ALL SELECT 'Bachelor of Science in Chemistry', 66, 3, 'DoC' FROM dual
UNION ALL SELECT 'Master of Science in Chemistry', 48, 2, 'DoC' FROM dual
UNION ALL SELECT 'Bachelor of Science in Environmental Science', 66, 3, 'DoES' FROM dual;
SELECT * FROM University_Courses
TRUNCATE TABLE University_Courses

INSERT INTO University_Subjects (Subject_Name, Subject_Credits, Subject_Coordinator, Course_ID, Faculty_ID)
SELECT 'Introduction to Programming', 3, 'Prof Alice Johnson', '4BoTiCS96DoCSE', '10profAlJo955F' FROM dual
UNION ALL SELECT 'Data Structures', 4, 'Prof Alice Johnson', '4BoTiCS96DoCSE', '10profAlJo955F' FROM dual
UNION ALL SELECT 'Operating Systems', 4, 'Prof Alice Johnson', '4BoTiCS96DoCSE', '10profAlJo955F' FROM dual
UNION ALL SELECT 'Chemical Kinetics', 4, 'Mr Ian Thompson', '3BoSiC66DoC', '20mrIaTh645M' FROM dual
UNION ALL SELECT 'Analytical Chemistry', 3, 'Mr Ian Thompson', '3BoSiC66DoC', '20mrIaTh645M' FROM dual
UNION ALL SELECT 'Digital Marketing', 3, 'Ms Emma Davis', '3BoBA66DoBA', '12msEmDa885F' FROM dual
UNION ALL SELECT 'Organizational Behavior', 4, 'Ms Emma Davis', '3BoBA66DoBA', '12msEmDa885F' FROM dual
UNION ALL SELECT 'Thermodynamics', 4, 'Prof Carol Williams', '4BoTiME96DoME', '18profCaWi905F' FROM dual
UNION ALL SELECT 'Fluid Mechanics', 3, 'Prof Carol Williams', '4BoTiME96DoME', '18profCaWi905F' FROM dual
UNION ALL SELECT 'Genetics', 3, 'Prof Fiona Garcia', '3BoSiB66DoB', '11profFiGa855F' FROM dual
UNION ALL SELECT 'Linear Algebra', 3, 'Dr George Martinez', '3BoSiM66DoM', '13drGeMa955M' FROM dual
UNION ALL SELECT 'Statistics', 4, 'Dr George Martinez', '3BoSiM66DoM', '13drGeMa955M' FROM dual
UNION ALL SELECT 'Microeconomics', 3, 'Ms Emma Davis', '3BoBA66DoBA', '12msEmDa885F' FROM dual
UNION ALL SELECT 'Macroeconomics', 4, 'Ms Emma Davis', '3BoBA66DoBA', '12msEmDa885F' FROM dual
UNION ALL SELECT 'Database Systems', 3, 'Dr Brian Smith', '4BoTiEE96DoEE', '15drBrSm925M' FROM dual
UNION ALL SELECT 'Network Security', 4, 'Dr Brian Smith', '4BoTiEE96DoEE', '15drBrSm925M' FROM dual
UNION ALL SELECT 'Artificial Intelligence', 4, 'Prof Fiona Garcia', '2MoTiCS48DoCSE', '11profFiGa855F' FROM dual
UNION ALL SELECT 'Machine Learning', 3, 'Prof Alice Johnson', '2MoTiCS48DoCSE', '10profAlJo955F' FROM dual
UNION ALL SELECT 'Web Development', 3, 'Prof Alice Johnson', '2MoTiCS48DoCSE', '10profAlJo955F' FROM dual
UNION ALL SELECT 'Cloud Computing', 4, 'Prof Alice Johnson', '2MoTiCS48DoCSE', '10profAlJo955F' FROM dual
UNION ALL SELECT 'Signal Processing', 4, 'Prof Jessica Clark', '4BoTiEE96DoEE', '20profJeCl925F' FROM dual
UNION ALL SELECT 'Circuit Theory', 3, 'Dr Brian Smith', '4BoTiEE96DoEE', '15drBrSm925M' FROM dual
UNION ALL SELECT 'Design Patterns', 4, 'Ms Hannah Wilson', '3BoSiP66DoP', '14msHaWi875F' FROM dual
UNION ALL SELECT 'Public Policy', 3, 'Prof Jessica Clark', '3BoSiES66DoES', '20profJeCl925F' FROM dual
UNION ALL SELECT 'Social Research Methods', 4, 'Prof Jessica Clark', '3BoSiES66DoES', '20profJeCl925F' FROM dual
UNION ALL SELECT 'Biochemistry', 4, 'Prof Fiona Garcia', '3BoSiB66DoB', '11profFiGa855F' FROM dual
UNION ALL SELECT 'Biostatistics', 3, 'Prof Fiona Garcia', '3BoSiB66DoB', '11profFiGa855F' FROM dual;
SELECT * FROM University_Subjects
TRUNCATE TABLE University_Subjects

INSERT INTO University_Sections (Section_Name, Section_Coordinator, Section_Room, Section_Strength, Faculty_ID) 
SELECT 'A', 'Prof. Alice Johnson', 'A101', 25, '10profAlJo955F' FROM dual
UNION ALL SELECT 'B', 'Prof. Brian Smith', 'A102', 30, '15drBrSm925M' FROM dual
UNION ALL SELECT 'C', 'Prof. Carol Williams', 'A103', 28, '18profCaWi905F' FROM dual
UNION ALL SELECT 'A', 'Prof. David Brown', 'B201', 20, '19mrDaBr915M' FROM dual
UNION ALL SELECT 'B', 'Ms. Emma Davis', 'B202', 22, '12msEmDa885F' FROM dual
UNION ALL SELECT 'C', 'Prof. Fiona Garcia', 'B203', 18, '11profFiGa855F' FROM dual
UNION ALL SELECT 'D', 'Dr. George Martinez', 'B204', 24, '13drGeMa955M' FROM dual
UNION ALL SELECT 'A', 'Prof. Uma Roberts', 'C301', 35, '21mrsUmRo625F' FROM dual
UNION ALL SELECT 'B', 'Mr. Ian Thompson', 'C302', 31, '20mrIaTh645M' FROM dual
UNION ALL SELECT 'C', 'Prof. Jessica Clark', 'C303', 29, '20profJeCl925F' FROM dual
UNION ALL SELECT 'B', 'Dr. Zara Cook', 'D402', 27, '20msZaCo605F' FROM dual
UNION ALL SELECT 'C', 'Dr. Oscar Martin', 'D403', 23, '12drOsMa875M' FROM dual
UNION ALL SELECT 'A', 'Dr. Uma Roberts', 'E501', 36, '21mrsUmRo625F' FROM dual
UNION ALL SELECT 'C', 'Dr. Oscar Martin', 'E503', 20, '12drOsMa875M' FROM dual
UNION ALL SELECT 'A', 'Prof. Kathy Morris', 'F601', 32, '16drKaMo885F' FROM dual
UNION ALL SELECT 'B', 'Dr. Xena Nelson', 'F602', 19, '14drXeNe835F' FROM dual
UNION ALL SELECT 'C', 'Prof. Walter Cruz', 'F603', 21, '20mrWaCr615M' FROM dual
UNION ALL SELECT 'A', 'Prof. Hannah Wilson', 'G701', 26, '14msHaWi875F' FROM dual
UNION ALL SELECT 'B', 'Mr. Larry White', 'G702', 33, '19mrLaWh655M' FROM dual
UNION ALL SELECT 'B', 'Ms. Zara Cook', 'I902', 30, '20msZaCo605F' FROM dual;
SELECT * FROM University_Sections
TRUNCATE TABLE University_Sections

INSERT INTO University_Exams (Exam_Type, Subject_ID, Exam_Date, Maximum_Marks)
SELECT 'Midterm', 'IntoPr34BoTiCS96DoCSE', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'IntoPr34BoTiCS96DoCSE', TO_DATE('2024-06-20', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'DaSt44BoTiCS96DoCSE', TO_DATE('2024-03-16', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'DaSt44BoTiCS96DoCSE', TO_DATE('2024-06-21', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'OpSy44BoTiCS96DoCSE', TO_DATE('2024-03-17', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'OpSy44BoTiCS96DoCSE', TO_DATE('2024-06-22', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'ChKi43BoSiC66DoC', TO_DATE('2024-03-18', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'ChKi43BoSiC66DoC', TO_DATE('2024-06-23', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'AnCh33BoSiC66DoC', TO_DATE('2024-03-19', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'AnCh33BoSiC66DoC', TO_DATE('2024-06-24', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'DiMa33BoBA66DoBA', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'DiMa33BoBA66DoBA', TO_DATE('2024-06-25', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'OrBe43BoBA66DoBA', TO_DATE('2024-03-21', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'OrBe43BoBA66DoBA', TO_DATE('2024-06-26', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'Th44BoTiME96DoME', TO_DATE('2024-03-22', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'Th44BoTiME96DoME', TO_DATE('2024-06-27', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'FlMe34BoTiME96DoME', TO_DATE('2024-03-23', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'FlMe34BoTiME96DoME', TO_DATE('2024-06-28', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'Ge33BoSiB66DoB', TO_DATE('2024-03-24', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'Ge33BoSiB66DoB', TO_DATE('2024-06-29', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'LiAl33BoSiM66DoM', TO_DATE('2024-03-25', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'LiAl33BoSiM66DoM', TO_DATE('2024-06-30', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'St43BoSiM66DoM', TO_DATE('2024-03-26', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'St43BoSiM66DoM', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'Mi33BoBA66DoBA', TO_DATE('2024-03-27', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'Mi33BoBA66DoBA', TO_DATE('2024-07-02', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'Ma43BoBA66DoBA', TO_DATE('2024-03-28', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'Ma43BoBA66DoBA', TO_DATE('2024-07-03', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'DaSy34BoTiEE96DoEE', TO_DATE('2024-03-29', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'DaSy34BoTiEE96DoEE', TO_DATE('2024-07-04', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'NeSe44BoTiEE96DoEE', TO_DATE('2024-03-30', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'NeSe44BoTiEE96DoEE', TO_DATE('2024-07-05', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'ArIn42MoTiCS48DoCSE', TO_DATE('2024-03-31', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'ArIn42MoTiCS48DoCSE', TO_DATE('2024-07-06', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'MaLe32MoTiCS48DoCSE', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'MaLe32MoTiCS48DoCSE', TO_DATE('2024-07-07', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'WeDe32MoTiCS48DoCSE', TO_DATE('2024-04-02', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'WeDe32MoTiCS48DoCSE', TO_DATE('2024-07-08', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'ClCo42MoTiCS48DoCSE', TO_DATE('2024-04-03', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'ClCo42MoTiCS48DoCSE', TO_DATE('2024-07-09', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'SiPr44BoTiEE96DoEE', TO_DATE('2024-04-04', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'SiPr44BoTiEE96DoEE', TO_DATE('2024-07-10', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'CiTh34BoTiEE96DoEE', TO_DATE('2024-04-05', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'CiTh34BoTiEE96DoEE', TO_DATE('2024-07-11', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'DePa43BoSiP66DoP', TO_DATE('2024-04-06', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'DePa43BoSiP66DoP', TO_DATE('2024-07-12', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'PuPo33BoSiES66DoES', TO_DATE('2024-04-07', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'PuPo33BoSiES66DoES', TO_DATE('2024-07-13', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'SoReMe43BoSiES66DoES', TO_DATE('2024-04-08', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'SoReMe43BoSiES66DoES', TO_DATE('2024-07-14', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'Bi43BoSiB66DoB', TO_DATE('2024-04-09', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'Bi43BoSiB66DoB', TO_DATE('2024-07-15', 'YYYY-MM-DD'), 80 FROM dual
UNION ALL SELECT 'Midterm', 'Bi33BoSiB66DoB', TO_DATE('2024-04-10', 'YYYY-MM-DD'), 40 FROM dual
UNION ALL SELECT 'Final', 'Bi33BoSiB66DoB', TO_DATE('2024-07-16', 'YYYY-MM-DD'), 80 FROM dual;
SELECT * FROM University_Exams
TRUNCATE TABLE University_Exams

INSERT INTO University_Hostels (Hostel_Name, Hostel_Capacity, Warden_ID)
SELECT 'Sunrise Hostel', 150, 'W01' FROM dual
UNION ALL SELECT 'Moonlight Hostel', 120, 'W02' FROM dual
UNION ALL SELECT 'Greenfield Hostel', 200, 'W03' FROM dual
UNION ALL SELECT 'Blue Sky Hostel', 100, 'W04' FROM dual
UNION ALL SELECT 'Oak Tree Hostel', 180, 'W05' FROM dual
UNION ALL SELECT 'Maple Leaf Hostel', 160, 'W06' FROM dual
UNION ALL SELECT 'Pine Valley Hostel', 140, 'W07' FROM dual;
SELECT * FROM University_Hostels
TRUNCATE TABLE University_Hostels

INSERT INTO University_Library (Title, Author, Publication_Year, Available_Copies)
SELECT 'Introduction to Algorithms', 'Thomas H. Cormen', 2009, 12 FROM dual
UNION ALL SELECT 'Artificial Intelligence: A Modern Approach', 'Stuart Russell', 2010, 8 FROM dual
UNION ALL SELECT 'Clean Code: A Handbook of Agile Software Craftsmanship', 'Robert C. Martin', 2008, 15 FROM dual
UNION ALL SELECT 'The Pragmatic Programmer', 'Andrew Hunt', 1999, 10 FROM dual
UNION ALL SELECT 'Design Patterns: Elements of Reusable Object-Oriented Software', 'Erich Gamma', 1994, 6 FROM dual
UNION ALL SELECT 'Database System Concepts', 'Abraham Silberschatz', 2010, 7 FROM dual
UNION ALL SELECT 'The Art of Computer Programming, Volume 1', 'Donald E. Knuth', 1997, 5 FROM dual
UNION ALL SELECT 'The Mythical Man-Month: Essays on Software Engineering', 'Frederick P. Brooks', 1995, 9 FROM dual
UNION ALL SELECT 'Computer Networks', 'Andrew S. Tanenbaum', 2010, 14 FROM dual
UNION ALL SELECT 'Compilers: Principles, Techniques, and Tools', 'Alfred V. Aho', 2006, 11 FROM dual
UNION ALL SELECT 'Java: The Complete Reference', 'Herbert Schildt', 2014, 16 FROM dual
UNION ALL SELECT 'Python for Data Analysis', 'Wes McKinney', 2017, 20 FROM dual
UNION ALL SELECT 'The C Programming Language', 'Brian W. Kernighan', 1988, 13 FROM dual
UNION ALL SELECT 'Head First Design Patterns', 'Eric Freeman', 2004, 10 FROM dual
UNION ALL SELECT 'Effective Java', 'Joshua Bloch', 2017, 18 FROM dual
UNION ALL SELECT 'You Dont Know JS: ES6 & Beyond', 'Kyle Simpson', 2015, 9 FROM dual
UNION ALL SELECT 'Learning SQL', 'Alan Beaulieu', 2009, 11 FROM dual
UNION ALL SELECT 'Cracking the Coding Interview', 'Gayle Laakmann McDowell', 2015, 10 FROM dual
UNION ALL SELECT 'Structure and Interpretation of Computer Programs', 'Harold Abelson', 1996, 7 FROM dual
UNION ALL SELECT 'Operating System Concepts', 'Abraham Silberschatz', 2012, 12 FROM dual
UNION ALL SELECT 'Programming Pearls', 'Jon Bentley', 1999, 5 FROM dual
UNION ALL SELECT 'Code Complete', 'Steve McConnell', 2004, 14 FROM dual
UNION ALL SELECT 'The Linux Programming Interface', 'Michael Kerrisk', 2010, 6 FROM dual
UNION ALL SELECT 'Unix Network Programming', 'W. Richard Stevens', 1998, 8 FROM dual
UNION ALL SELECT 'The Clean Coder', 'Robert C. Martin', 2011, 10 FROM dual
UNION ALL SELECT 'Deep Learning', 'Ian Goodfellow', 2016, 9 FROM dual
UNION ALL SELECT 'Introduction to the Theory of Computation', 'Michael Sipser', 2012, 7 FROM dual
UNION ALL SELECT 'Agile Estimating and Planning', 'Mike Cohn', 2005, 6 FROM dual
UNION ALL SELECT 'JavaScript: The Good Parts', 'Douglas Crockford', 2008, 14 FROM dual
UNION ALL SELECT 'Refactoring: Improving the Design of Existing Code', 'Martin Fowler', 2018, 9 FROM dual
UNION ALL SELECT 'The Design of Everyday Things', 'Don Norman', 2013, 13 FROM dual
UNION ALL SELECT 'Algorithms', 'Robert Sedgewick', 2011, 11 FROM dual
UNION ALL SELECT 'Artificial Intelligence: Foundations of Computational Agents', 'David L. Poole', 2010, 5 FROM dual
UNION ALL SELECT 'Digital Design and Computer Architecture', 'David Harris', 2012, 10 FROM dual
UNION ALL SELECT 'Head First Java', 'Kathy Sierra', 2005, 15 FROM dual
UNION ALL SELECT 'Python Crash Course', 'Eric Matthes', 2015, 17 FROM dual
UNION ALL SELECT 'The Elements of Statistical Learning', 'Trevor Hastie', 2009, 6 FROM dual
UNION ALL SELECT 'Spring in Action', 'Craig Walls', 2018, 7 FROM dual
UNION ALL SELECT 'Computer Organization and Design', 'David A. Patterson', 2013, 11 FROM dual
UNION ALL SELECT 'Fluent Python', 'Luciano Ramalho', 2015, 9 FROM dual
UNION ALL SELECT 'Introduction to Machine Learning with Python', 'Andreas C. Müller', 2016, 8 FROM dual
UNION ALL SELECT 'Pro Git', 'Scott Chacon', 2014, 14 FROM dual
UNION ALL SELECT 'The Pragmatic Programmer', 'David Thomas', 2019, 16 FROM dual
UNION ALL SELECT 'Introduction to Data Mining', 'Pang-Ning Tan', 2005, 7 FROM dual
UNION ALL SELECT 'Data Science from Scratch', 'Joel Grus', 2019, 9 FROM dual
UNION ALL SELECT 'The Go Programming Language', 'Alan A. A. Donovan', 2015, 10 FROM dual
UNION ALL SELECT 'Learning Spark', 'Holden Karau', 2020, 12 FROM dual
UNION ALL SELECT 'Machine Learning Yearning', 'Andrew Ng', 2019, 18 FROM dual
UNION ALL SELECT 'The Art of Scalability', 'Martin L. Abbott', 2015, 5 FROM dual
UNION ALL SELECT 'Continuous Delivery', 'Jez Humble', 2010, 9 FROM dual;
SELECT * FROM University_Library
TRUNCATE TABLE University_Library

INSERT INTO University_Students (First_Name, Last_Name, Father_Name, DOB, Gender, Contact_Number, Address, Blood_Group, Year_Enrolled, Section_ID, Hostel_ID)
SELECT 'Emily','Johnson','Michael Johnson',TO_DATE('2002-02-15','YYYY-MM-DD'),'F',9876543210,'123 Elm St, Springfield','A+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'David','Smith','Robert Smith',TO_DATE('2001-06-20','YYYY-MM-DD'),'M',8765432109,'456 Oak St, Rivertown','B-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Sarah','Williams','Thomas Williams',TO_DATE('2002-03-25','YYYY-MM-DD'),'F',7654321098,'789 Maple Ave, Lakeview','O+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'John','Brown','Charles Brown',TO_DATE('2000-11-11','YYYY-MM-DD'),'M',6543210987,'321 Pine Rd, Hilltop','A-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Jessica','Davis','William Davis',TO_DATE('2002-07-30','YYYY-MM-DD'),'F',5432109876,'654 Cedar Blvd, Valley','AB+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Daniel','Miller','James Miller',TO_DATE('2001-08-14','YYYY-MM-DD'),'M',4321098765,'987 Birch St, Greendale','O-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Laura','Wilson','Richard Wilson',TO_DATE('2002-04-12','YYYY-MM-DD'),'F',3210987654,'159 Willow Way, Brookfield','B+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Michael','Taylor','Steven Taylor',TO_DATE('2001-09-08','YYYY-MM-DD'),'M',2109876543,'753 Ash St, Mountainview','A+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Olivia','Anderson','Edward Anderson',TO_DATE('2002-05-19','YYYY-MM-DD'),'F',1098765432,'852 Palm Dr, Clearwater','AB-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Joshua','Thomas','Joseph Thomas',TO_DATE('2000-12-22','YYYY-MM-DD'),'M',9988776655,'246 Spruce Ct, Harmony','O+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Sophia','Jackson','Brian Jackson',TO_DATE('2001-01-30','YYYY-MM-DD'),'F',8877665544,'135 Chestnut Ln, Newport','B-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'James','White','Ronald White',TO_DATE('2002-10-03','YYYY-MM-DD'),'M',7766554433,'420 Walnut St, Eastside','A-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Charlotte','Harris','Kevin Harris',TO_DATE('2002-12-15','YYYY-MM-DD'),'F',6655443322,'678 Sycamore Way, Riverview','O-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Ethan','Martin','Gregory Martin',TO_DATE('2001-04-06','YYYY-MM-DD'),'M',5544332211,'321 Cherry Blvd, Crestview','AB+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Mia','Thompson','Frank Thompson',TO_DATE('2001-07-28','YYYY-MM-DD'),'F',4433221100,'543 Peach St, Southtown','A+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Benjamin','Garcia','Edward Garcia',TO_DATE('2002-08-09','YYYY-MM-DD'),'M',3322110099,'987 Lemon Ave, Oakdale','B+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Lily','Martinez','Samuel Martinez',TO_DATE('2000-03-16','YYYY-MM-DD'),'F',2211009988,'654 Orange Ct, Fairview','O-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Jacob','Robinson','Charles Robinson',TO_DATE('2002-09-04','YYYY-MM-DD'),'M',1100998877,'234 Grape St, Woodside','AB-',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Chloe','Clark','Timothy Clark',TO_DATE('2001-11-11','YYYY-MM-DD'),'F',9099887766,'789 Berry Blvd, Valley','A+',2020,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Ethan','Williams','James Williams',TO_DATE('2002-01-12','YYYY-MM-DD'),'M',9876543210,'432 Birch Ln, Hilltop','A+',2021,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Ava','Johnson','Charles Johnson',TO_DATE('2001-05-25','YYYY-MM-DD'),'F',8765432109,'210 Maple St, Crestwood','B-',2021,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Mia','Smith','Robert Smith',TO_DATE('2002-03-07','YYYY-MM-DD'),'F',7654321098,'789 Cedar Rd, Riverview','O+',2021,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Liam','Brown','Michael Brown',TO_DATE('2000-11-20','YYYY-MM-DD'),'M',6543210987,'321 Oak St, Eastside','A-',2021,'A25PrAlJoA101','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Harper','Davis','William Davis',TO_DATE('2002-06-15','YYYY-MM-DD'),'F',5432109876,'654 Pine Ct, Greenfield','AB+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Noah','Taylor','Richard Taylor',TO_DATE('2001-09-30','YYYY-MM-DD'),'M',4321098765,'159 Elm St, Brookfield','O-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Isabella','Martinez','Thomas Martinez',TO_DATE('2002-02-28','YYYY-MM-DD'),'F',3210987654,'852 Palm Dr, Lakeside','B+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Lucas','Garcia','Edward Garcia',TO_DATE('2001-08-12','YYYY-MM-DD'),'M',2109876543,'753 Spruce Ct, Clearwater','A+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Charlotte','Hernandez','Joseph Hernandez',TO_DATE('2002-05-04','YYYY-MM-DD'),'F',1098765432,'135 Cherry Blvd, Harmony','AB-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Mason','Wilson','Brian Wilson',TO_DATE('2000-12-14','YYYY-MM-DD'),'M',9988776655,'246 Maple Ave, Sunnydale','O+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Amelia','Anderson','Frank Anderson',TO_DATE('2001-03-18','YYYY-MM-DD'),'F',8877665544,'135 Birch St, Woodside','B-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Elijah','Clark','Timothy Clark',TO_DATE('2002-07-21','YYYY-MM-DD'),'M',7766554433,'420 Walnut St, Riverside','A-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Ella','Lewis','Robert Lewis',TO_DATE('2002-10-03','YYYY-MM-DD'),'F',6655443322,'678 Oak St, Greenfield','O-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Alexander','Robinson','Samuel Robinson',TO_DATE('2001-04-09','YYYY-MM-DD'),'M',5544332211,'543 Cedar Ct, Northside','AB+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Scarlett','Lee','Charles Lee',TO_DATE('2001-11-15','YYYY-MM-DD'),'F',4433221100,'321 Chestnut Ln, Westfield','A+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Daniel','Young','Gregory Young',TO_DATE('2002-08-27','YYYY-MM-DD'),'M',3322110099,'987 Maple Blvd, Riverview','B+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Grace','Allen','Brian Allen',TO_DATE('2000-02-10','YYYY-MM-DD'),'F',2211009988,'654 Elm St, Lakeview','O-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'William','King','Joseph King',TO_DATE('2002-09-20','YYYY-MM-DD'),'M',1100998877,'234 Oak Dr, Sunnyvale','AB-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Sophia','Wright','David Wright',TO_DATE('2001-01-01','YYYY-MM-DD'),'F',9099887766,'789 Pine Ct, Riverview','A+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Jacob','Adams','Steven Adams',TO_DATE('2002-03-15','YYYY-MM-DD'),'M',9876543210,'876 Willow Rd, Elmwood','B+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Mia','Thompson','Charles Thompson',TO_DATE('2001-12-10','YYYY-MM-DD'),'F',8765432109,'543 Maple St, Oakdale','O-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'James','White','David White',TO_DATE('2000-11-22','YYYY-MM-DD'),'M',7654321098,'234 Cedar Ave, Maplewood','A+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Emma','Harris','Robert Harris',TO_DATE('2002-05-30','YYYY-MM-DD'),'F',6543210987,'987 Birch Blvd, Lakeside','AB-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'William','Martin','Thomas Martin',TO_DATE('2001-07-18','YYYY-MM-DD'),'M',5432109876,'456 Oak St, Hillcrest','A-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Abigail','Thompson','Richard Thompson',TO_DATE('2002-09-12','YYYY-MM-DD'),'F',4321098765,'159 Elm St, Cedarwood','O+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Benjamin','Garcia','Samuel Garcia',TO_DATE('2002-01-05','YYYY-MM-DD'),'M',3210987654,'753 Walnut Ln, Seaside','B-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Olivia','Rodriguez','Gregory Rodriguez',TO_DATE('2001-08-14','YYYY-MM-DD'),'F',2109876543,'258 Pine Ct, Crestview','AB+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Lucas','Lewis','Charles Lewis',TO_DATE('2000-04-03','YYYY-MM-DD'),'M',1098765432,'369 Spruce Dr, Valleyview','A+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Isabella','Walker','Paul Walker',TO_DATE('2001-10-29','YYYY-MM-DD'),'F',9988776655,'654 Maple Ave, Eastview','B+',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Daniel','Hall','Edward Hall',TO_DATE('2000-02-22','YYYY-MM-DD'),'M',8877665544,'741 Oak St, Glenwood','O-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Harper','Allen','Matthew Allen',TO_DATE('2002-06-11','YYYY-MM-DD'),'F',7766554433,'159 Maple Blvd, Meadowview','A-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Elijah','Young','Brian Young',TO_DATE('2001-11-04','YYYY-MM-DD'),'M',6655443322,'321 Oak Ln, Greenwood','AB-',2021,'B30PrBrSmA102','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Ava','King','Joseph King',TO_DATE('2002-02-17','YYYY-MM-DD'),'F',5544332211,'456 Birch St, Lakewood','A+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Jacob','Scott','Charles Scott',TO_DATE('2001-03-26','YYYY-MM-DD'),'M',4433221100,'789 Pine Ave, Brookfield','O+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Grace','Carter','Samuel Carter',TO_DATE('2000-10-15','YYYY-MM-DD'),'F',3322110099,'135 Cedar Rd, Riverview','B-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Noah','Cooper','Matthew Cooper',TO_DATE('2002-07-01','YYYY-MM-DD'),'M',2211009988,'456 Oak Blvd, Crestwood','AB+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Ella','Reed','Gregory Reed',TO_DATE('2001-09-09','YYYY-MM-DD'),'F',1100998877,'654 Maple St, Brookside','A-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'William','Parker','Brian Parker',TO_DATE('2002-08-28','YYYY-MM-DD'),'M',9099887766,'753 Birch Ave, Sunnyvale','O-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Samuel','Mitchell','Charles Mitchell',TO_DATE('2002-03-20','YYYY-MM-DD'),'M',9876543210,'123 Ocean Ave, Riverside','B+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Lily','Martinez','David Martinez',TO_DATE('2001-06-15','YYYY-MM-DD'),'F',8765432109,'234 Lake St, Hilltown','O-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Ethan','Brown','Steven Brown',TO_DATE('2000-12-01','YYYY-MM-DD'),'M',7654321098,'345 River Rd, Greendale','A+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Sophia','Anderson','Paul Anderson',TO_DATE('2002-05-05','YYYY-MM-DD'),'F',6543210987,'456 Meadow Ln, Seaside','AB-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Jackson','Thomas','Edward Thomas',TO_DATE('2001-09-14','YYYY-MM-DD'),'M',5432109876,'567 Pine St, Westfield','A-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Mia','Taylor','Matthew Taylor',TO_DATE('2002-07-29','YYYY-MM-DD'),'F',4321098765,'678 Elm St, Brookville','O+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Aiden','Harris','Joseph Harris',TO_DATE('2000-11-11','YYYY-MM-DD'),'M',3210987654,'789 Oak Dr, Maplewood','B-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Ava','White','Samuel White',TO_DATE('2001-08-20','YYYY-MM-DD'),'F',2109876543,'890 Cedar Blvd, Eastwood','AB+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'William','Garcia','Gregory Garcia',TO_DATE('2002-02-25','YYYY-MM-DD'),'M',1098765432,'123 Birch Ln, Southside','A+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Emily','Robinson','Brian Robinson',TO_DATE('2001-01-12','YYYY-MM-DD'),'F',9988776655,'234 Ocean Dr, Northview','B+',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Daniel','Lewis','Charles Lewis',TO_DATE('2002-04-16','YYYY-MM-DD'),'M',8877665544,'345 Sunset Blvd, Riverside','O-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Charlotte','Walker','Edward Walker',TO_DATE('2001-10-30','YYYY-MM-DD'),'F',7766554433,'456 Shoreline Rd, Crestview','A-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Michael','Young','Joseph Young',TO_DATE('2000-03-09','YYYY-MM-DD'),'M',6655443322,'567 Valley Dr, Greenfield','AB-',2021,'C28PrCaWiA103','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT 'Harper','King','Richard King',TO_DATE('2002-06-23','YYYY-MM-DD'),'F',5544332211,'678 Hill St, Sunnydale','A+',2021,'C28PrCaWiA103','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Benjamin','Scott','Thomas Scott',TO_DATE('2001-12-12','YYYY-MM-DD'),'M',4433221100,'789 River Blvd, Seaside','O+',2021,'C28PrCaWiA103','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ella','Green','Samuel Green',TO_DATE('2002-07-05','YYYY-MM-DD'),'F',3322110099,'890 Meadow Ln, Oakwood','B-',2021,'C28PrCaWiA103','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Joshua','Hall','Matthew Hall',TO_DATE('2001-11-14','YYYY-MM-DD'),'M',2211009988,'123 Elm St, Lakeside','AB+',2021,'C28PrCaWiA103','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Sofia','Allen','Brian Allen',TO_DATE('2000-04-17','YYYY-MM-DD'),'F',1100998877,'234 Maple Blvd, Westview','A-',2021,'C28PrCaWiA103','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Lucas','King','Charles King',TO_DATE('2002-01-28','YYYY-MM-DD'),'M',9099887766,'345 Sunset Rd, Hillcrest','O-',2021,'C28PrCaWiA103','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'James','Harris','Thomas Harris',TO_DATE('2001-01-19','YYYY-MM-DD'),'M',9876543210,'564 Pine St, Riverside','B+',2021,'C28PrCaWiA103','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Mia','White','Samuel White',TO_DATE('2000-03-05','YYYY-MM-DD'),'F',8765432109,'765 Maple Ave, Elmwood','O-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'William','Thompson','Robert Thompson',TO_DATE('2002-06-21','YYYY-MM-DD'),'M',7654321098,'456 Cedar Blvd, Westfield','A+',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Sophia','Martinez','Charles Martinez',TO_DATE('2001-09-13','YYYY-MM-DD'),'F',6543210987,'987 Willow Rd, Greendale','AB-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Benjamin','Brown','Edward Brown',TO_DATE('2002-11-29','YYYY-MM-DD'),'M',5432109876,'234 Ocean St, Hilltown','A-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Isabella','Lewis','David Lewis',TO_DATE('2000-07-23','YYYY-MM-DD'),'F',4321098765,'567 River Ln, Eastwood','O+',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ethan','Wilson','Matthew Wilson',TO_DATE('2001-04-10','YYYY-MM-DD'),'M',3210987654,'890 Meadow Rd, Maplewood','B-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ella','Anderson','James Anderson',TO_DATE('2002-05-18','YYYY-MM-DD'),'F',2109876543,'123 Birch Blvd, Brookfield','AB+',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Lucas','Martinez','Paul Martinez',TO_DATE('2001-10-30','YYYY-MM-DD'),'M',1098765432,'456 Hill St, Southside','A+',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Charlotte','Rodriguez','Joseph Rodriguez',TO_DATE('2002-01-15','YYYY-MM-DD'),'F',9988776655,'789 River Ave, Sunnyvale','B+',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Jackson','Taylor','Samuel Taylor',TO_DATE('2001-03-28','YYYY-MM-DD'),'M',8877665544,'135 Ocean Blvd, Greenfield','O-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Abigail','Scott','Charles Scott',TO_DATE('2002-12-05','YYYY-MM-DD'),'F',7766554433,'246 Shoreline Rd, Crestview','A-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Aiden','Harris','Robert Harris',TO_DATE('2000-02-14','YYYY-MM-DD'),'M',6655443322,'357 Meadow Ln, Riverside','AB-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Elijah','Young','Thomas Young',TO_DATE('2001-11-24','YYYY-MM-DD'),'F',5544332211,'468 Maple Dr, Lakewood','A+',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Grace','Hall','Edward Hall',TO_DATE('2002-04-17','YYYY-MM-DD'),'M',4433221100,'579 Cedar St, Hillcrest','O+',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Daniel','King','Matthew King',TO_DATE('2001-06-08','YYYY-MM-DD'),'F',3322110099,'680 Birch Ave, Northview','B-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'William','Lewis','Joseph Lewis',TO_DATE('2002-08-10','YYYY-MM-DD'),'M',2211009988,'791 Oak St, Greendale','AB+',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Sofia','Green','Charles Green',TO_DATE('2000-05-29','YYYY-MM-DD'),'F',1100998877,'802 Ocean Ave, Maplewood','A-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Jacob','Allen','Samuel Allen',TO_DATE('2001-09-18','YYYY-MM-DD'),'M',9099887766,'913 Meadow Blvd, Westfield','O-',2021,'A20PrDaBrB201','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Mia','Robinson','David Robinson',TO_DATE('2001-02-20','YYYY-MM-DD'),'F',9876543210,'478 Hill St, Riverside','B+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'William','Johnson','Charles Johnson',TO_DATE('2000-03-10','YYYY-MM-DD'),'M',8765432109,'123 Maple Ave, Hilltown','O-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Emily','Davis','Steven Davis',TO_DATE('2001-08-25','YYYY-MM-DD'),'F',7654321098,'234 River Rd, Greendale','A+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Jacob','Brown','Edward Brown',TO_DATE('2002-10-14','YYYY-MM-DD'),'M',6543210987,'345 Cedar Blvd, Westfield','AB-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Abigail','Wilson','Joseph Wilson',TO_DATE('2001-05-18','YYYY-MM-DD'),'F',5432109876,'456 Shoreline Rd, Eastwood','A-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Samuel','Taylor','Matthew Taylor',TO_DATE('2000-01-29','YYYY-MM-DD'),'M',4321098765,'567 Oak St, Maplewood','O+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Lucas','Scott','Brian Scott',TO_DATE('2002-11-05','YYYY-MM-DD'),'M',3210987654,'678 Pine Ln, Brookfield','B-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ella','Martinez','Thomas Martinez',TO_DATE('2001-07-22','YYYY-MM-DD'),'F',2109876543,'789 Ocean Blvd, Northview','AB+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Aiden','King','Charles King',TO_DATE('2002-09-30','YYYY-MM-DD'),'M',1098765432,'890 Meadow Ln, Hillcrest','A+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Charlotte','Young','Joseph Young',TO_DATE('2000-06-14','YYYY-MM-DD'),'F',9988776655,'123 River Dr, Lakewood','B+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Michael','Anderson','Edward Anderson',TO_DATE('2001-04-11','YYYY-MM-DD'),'M',8877665544,'234 Birch Rd, Sunnyvale','O-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Grace','Harris','Matthew Harris',TO_DATE('2002-05-23','YYYY-MM-DD'),'F',7766554433,'345 Cedar Ave, Greendale','A-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Joshua','White','Samuel White',TO_DATE('2001-03-07','YYYY-MM-DD'),'M',6655443322,'456 Maple Blvd, Westfield','AB-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Lily','Robinson','Charles Robinson',TO_DATE('2000-12-01','YYYY-MM-DD'),'F',5544332211,'567 River Ave, Eastwood','A+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ethan','Lewis','Brian Lewis',TO_DATE('2002-02-20','YYYY-MM-DD'),'M',4433221100,'678 Ocean St, Riverside','O+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Sofia','Taylor','David Taylor',TO_DATE('2001-11-14','YYYY-MM-DD'),'F',3322110099,'789 Hill Rd, Greendale','B-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'William','Scott','Thomas Scott',TO_DATE('2000-09-21','YYYY-MM-DD'),'M',2211009988,'890 Meadow Ln, Hillcrest','AB+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'James','Garcia','Edward Garcia',TO_DATE('2001-06-18','YYYY-MM-DD'),'M',1100998877,'901 Pine Blvd, Maplewood','A-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ava','Allen','Joseph Allen',TO_DATE('2002-01-05','YYYY-MM-DD'),'F',9099887766,'123 Maple Dr, Northview','O-',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Mia','Clark','Robert Clark',TO_DATE('2001-03-22','YYYY-MM-DD'),'F',9876543210,'234 Ocean Blvd, Lakeside','B+',2021,'B22MsEmDaB202','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'James','Smith','Robert Smith',TO_DATE('2000-05-15','YYYY-MM-DD'),'M',9876543210,'45 Oak Street, Cityville','A+',2020,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Emily','Johnson','David Johnson',TO_DATE('2001-08-22','YYYY-MM-DD'),'F',8765432109,'67 Pine Avenue, Townsville','B+',2020,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Liam','Williams','John Williams',TO_DATE('1999-12-01','YYYY-MM-DD'),'M',7654321098,'89 Maple Lane, Villageburg','O-',2021,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Sophia','Brown','Michael Brown',TO_DATE('2000-11-10','YYYY-MM-DD'),'F',6543210987,'101 Cedar Drive, Citytown','AB+',2021,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Noah','Jones','William Jones',TO_DATE('2002-03-05','YYYY-MM-DD'),'M',5432109876,'34 Elm Street, Hamlet','A-',2022,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Mia','Garcia','Richard Garcia',TO_DATE('2000-07-30','YYYY-MM-DD'),'F',4321098765,'23 Birch Blvd, District','B-',2020,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ethan','Martinez','Charles Martinez',TO_DATE('2001-09-15','YYYY-MM-DD'),'M',3210987654,'12 Willow Way, Cityland','O+',2021,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ava','Davis','Thomas Davis',TO_DATE('2000-06-28','YYYY-MM-DD'),'F',2109876543,'78 Fir Street, Townville','AB-',2022,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Mason','Rodriguez','Anthony Rodriguez',TO_DATE('1998-04-12','YYYY-MM-DD'),'M',1098765432,'9 Oak Lane, Citycenter','A+',2019,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Isabella','Hernandez','Mark Hernandez',TO_DATE('2002-10-23','YYYY-MM-DD'),'F',9878909876,'5 Spruce Avenue, Ville','B+',2023,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Lucas','Wilson','Joshua Wilson',TO_DATE('2001-02-14','YYYY-MM-DD'),'M',8765432101,'60 Maple Road, Towncity','O-',2020,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Amelia','Lee','Robert Lee',TO_DATE('1999-07-20','YYYY-MM-DD'),'F',7654321090,'80 Elm Street, Citypoint','AB+',2019,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Aiden','Lewis','David Lewis',TO_DATE('2002-05-18','YYYY-MM-DD'),'M',6543210989,'11 Pine Boulevard, Village','A-',2021,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Chloe','Walker','Paul Walker',TO_DATE('2000-12-30','YYYY-MM-DD'),'F',5432109878,'90 Birch Road, Hamlet','B-',2020,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Jackson','Hall','George Hall',TO_DATE('1999-08-17','YYYY-MM-DD'),'M',4321098767,'3 Cedar Lane, District','O+',2021,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Mia','Young','Jonathan Young',TO_DATE('2001-03-26','YYYY-MM-DD'),'F',3210987656,'45 Willow Way, Citytown','AB-',2022,'C18PrFiGaB203','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Logan','King','Edward King',TO_DATE('2000-11-30','YYYY-MM-DD'),'M',2109876545,'33 Fir Avenue, Cityland','A+',2020,'D24DrGeMaB204','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Benjamin','White','Adam White',TO_DATE('2000-04-12','YYYY-MM-DD'),'M',9876543210,'72 Cherry Ave, Cityville','O+',2020,'D24DrGeMaB204','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Grace','Thompson','Frank Thompson',TO_DATE('1999-05-15','YYYY-MM-DD'),'F',8765432109,'54 Oak Street, Townsville','A-',2019,'D24DrGeMaB204','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Samuel','Martinez','Jason Martinez',TO_DATE('2001-07-24','YYYY-MM-DD'),'M',7654321098,'33 Birch Boulevard, Citytown','B+',2021,'D24DrGeMaB204','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Abigail','Anderson','Samuel Anderson',TO_DATE('2000-12-30','YYYY-MM-DD'),'F',6543210987,'16 Pine Lane, Hamlet','AB-',2022,'D24DrGeMaB204','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Henry','Taylor','Joseph Taylor',TO_DATE('2002-10-05','YYYY-MM-DD'),'M',5432109876,'12 Cedar Street, Village','O-',2020,'D24DrGeMaB204','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Ella','Thomas','Thomas Thomas',TO_DATE('2001-11-18','YYYY-MM-DD'),'F',4321098765,'9 Maple Ave, Citycenter','B-',2021,'D24DrGeMaB204','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Wyatt','Jackson','Gary Jackson',TO_DATE('2000-06-28','YYYY-MM-DD'),'M',3210987654,'100 Elm Blvd, Citypoint','A+',2021,'D24DrGeMaB204','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT 'Scarlett','Harris','Peter Harris',TO_DATE('2000-09-22','YYYY-MM-DD'),'F',2109876543,'45 Fir Road, Hamlet','O+',2022,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Owen','Martin','Matthew Martin',TO_DATE('2002-01-15','YYYY-MM-DD'),'M',1098765432,'77 Birch Ave, Towncity','A-',2021,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Victoria','Thompson','Charles Thompson',TO_DATE('1998-04-10','YYYY-MM-DD'),'F',9878909876,'45 Oak Street, Cityland','B+',2019,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Alexander','Robinson','Jonathan Robinson',TO_DATE('2001-02-28','YYYY-MM-DD'),'M',8765432101,'23 Pine Lane, District','O-',2020,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Sofia','Clark','Albert Clark',TO_DATE('2000-03-16','YYYY-MM-DD'),'F',7654321090,'91 Fir Blvd, Citycenter','AB+',2021,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Anthony','Rodriguez','Michael Rodriguez',TO_DATE('2001-11-20','YYYY-MM-DD'),'M',6543210989,'12 Cedar Lane, Citytown','A-',2020,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Lila','Lewis','Sarah Lewis',TO_DATE('2000-08-10','YYYY-MM-DD'),'F',5432109878,'34 Oak Blvd, Hamlet','B-',2021,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Lucas','Lee','William Lee',TO_DATE('2000-12-30','YYYY-MM-DD'),'M',4321098767,'99 Maple Ave, Cityland','O+',2022,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Emma','Allen','Thomas Allen',TO_DATE('2002-09-17','YYYY-MM-DD'),'F',3210987656,'76 Birch Blvd, Townsville','AB-',2020,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Jack','Walker','Gary Walker',TO_DATE('2001-03-09','YYYY-MM-DD'),'M',2109876545,'44 Cedar Lane, District','A+',2021,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Olivia','Perez','Carlos Perez',TO_DATE('2000-05-10','YYYY-MM-DD'),'F',9876543210,'65 Oak Street, Cityville','O+',2020,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Sebastian','Green','Harry Green',TO_DATE('2001-02-19','YYYY-MM-DD'),'M',8765432109,'55 Elm Street, Townsville','A-',2020,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Amelia','Hill','Steven Hill',TO_DATE('1999-06-25','YYYY-MM-DD'),'F',7654321098,'3 Maple Lane, Citytown','B+',2021,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Lucas','Scott','Dennis Scott',TO_DATE('2000-07-30','YYYY-MM-DD'),'M',6543210987,'11 Cedar Boulevard, Hamlet','AB-',2022,'D24DrGeMaB204','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Mia','Adams','David Adams',TO_DATE('2000-10-14','YYYY-MM-DD'),'F',5432109876,'20 Pine Ave, Village','O-',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Alexander','Nelson','Mark Nelson',TO_DATE('2001-03-01','YYYY-MM-DD'),'M',4321098765,'67 Birch Blvd, Cityland','A-',2022,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Chloe','Carter','Robert Carter',TO_DATE('2000-04-05','YYYY-MM-DD'),'F',3210987654,'12 Maple St, Citypoint','B-',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Benjamin','Sanchez','Daniel Sanchez',TO_DATE('2001-11-23','YYYY-MM-DD'),'M',2109876543,'22 Fir Avenue, Hamlet','O+',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Sophia','Perez','Frank Perez',TO_DATE('2002-12-15','YYYY-MM-DD'),'F',1098765432,'77 Cedar Street, District','AB+',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'William','Morris','Anthony Morris',TO_DATE('2000-09-20','YYYY-MM-DD'),'M',9878909876,'32 Pine Road, Cityland','A-',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Harper','Rogers','Charles Rogers',TO_DATE('2000-03-28','YYYY-MM-DD'),'F',8765432101,'10 Birch Lane, Townsville','B+',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Jackson','Reed','Michael Reed',TO_DATE('2001-10-10','YYYY-MM-DD'),'M',7654321090,'14 Oak Avenue, Citytown','O-',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Ella','Cooper','George Cooper',TO_DATE('1999-08-19','YYYY-MM-DD'),'F',6543210989,'55 Maple Road, Hamlet','AB-',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Mason','Bell','Robert Bell',TO_DATE('2000-07-22','YYYY-MM-DD'),'M',5432109878,'39 Cedar Ave, Village','A+',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Lily','Murphy','Edward Murphy',TO_DATE('2000-05-18','YYYY-MM-DD'),'F',4321098767,'99 Elm Blvd, Citycenter','O+',2022,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Daniel','Diaz','Harry Diaz',TO_DATE('2001-01-01','YYYY-MM-DD'),'M',3210987656,'45 Oak Street, District','AB-',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Natalie','Ramirez','Jason Ramirez',TO_DATE('2002-06-12','YYYY-MM-DD'),'F',2109876545,'24 Birch St, Townsville','A+',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Oliver','Perez','Frank Perez',TO_DATE('2000-01-25','YYYY-MM-DD'),'M',9876543210,'75 Cherry Ave, Cityville','O-',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Mia','Taylor','Anthony Taylor',TO_DATE('1999-03-15','YYYY-MM-DD'),'F',8765432109,'34 Oak Street, Townsville','A+',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Elijah','Brown','Robert Brown',TO_DATE('2001-06-10','YYYY-MM-DD'),'M',7654321098,'19 Maple Lane, Citytown','B-',2022,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Charlotte','Johnson','Charles Johnson',TO_DATE('2000-10-20','YYYY-MM-DD'),'F',6543210987,'88 Pine Boulevard, Hamlet','AB+',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Lucas','Miller','Thomas Miller',TO_DATE('2002-12-12','YYYY-MM-DD'),'M',5432109876,'41 Birch Ave, Village','O+',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Sophia','Davis','Mark Davis',TO_DATE('2001-05-30','YYYY-MM-DD'),'F',4321098765,'29 Cedar St, Cityland','A-',2022,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'James','Wilson','David Wilson',TO_DATE('2000-07-28','YYYY-MM-DD'),'M',3210987654,'77 Elm Road, District','B+',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Lily','Moore','Edward Moore',TO_DATE('1999-11-04','YYYY-MM-DD'),'F',2109876543,'50 Maple Blvd, Citypoint','O-',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Benjamin','Taylor','Joshua Taylor',TO_DATE('2001-03-14','YYYY-MM-DD'),'M',1098765432,'90 Cedar Ave, Hamlet','AB-',2022,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Ava','Clark','Jacob Clark',TO_DATE('2000-04-25','YYYY-MM-DD'),'F',9878909876,'15 Birch Blvd, Cityland','A+',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Wyatt','Roberts','Anthony Roberts',TO_DATE('2000-02-19','YYYY-MM-DD'),'M',8765432101,'43 Oak Ave, Townsville','B+',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Harper','Lewis','Kevin Lewis',TO_DATE('2001-08-15','YYYY-MM-DD'),'F',7654321090,'80 Pine St, Citypoint','O-',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Jackson','Hall','Paul Hall',TO_DATE('1998-12-11','YYYY-MM-DD'),'M',6543210989,'3 Maple Ave, Hamlet','AB+',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Scarlett','Adams','Andrew Adams',TO_DATE('2002-09-18','YYYY-MM-DD'),'F',5432109878,'66 Cedar Blvd, Cityland','A-',2022,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Daniel','Wilson','William Wilson',TO_DATE('2000-07-30','YYYY-MM-DD'),'M',4321098767,'99 Elm St, Citycenter','B-',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Evelyn','Young','Edward Young',TO_DATE('2000-11-22','YYYY-MM-DD'),'F',3210987656,'5 Fir Blvd, District','O+',2022,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Gabriel','Turner','Charles Turner',TO_DATE('2001-04-09','YYYY-MM-DD'),'M',2109876545,'77 Maple Lane, Cityville','AB-',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Amelia','Garcia','Robert Garcia',TO_DATE('2000-09-05','YYYY-MM-DD'),'F',9876543210,'82 Pine Street, Cityville','O-',2020,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Samuel','Martinez','Frank Martinez',TO_DATE('1999-02-20','YYYY-MM-DD'),'M',8765432109,'41 Cedar Ave, Townsville','A+',2021,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Scarlett','Lopez','Anthony Lopez',TO_DATE('2001-01-15','YYYY-MM-DD'),'F',7654321098,'11 Birch Blvd, Citytown','B-',2022,'A35PrUmRoC301','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Noah','Lee','Charles Lee',TO_DATE('2000-06-22','YYYY-MM-DD'),'M',6543210987,'30 Maple Lane, Hamlet','AB+',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Chloe','Allen','Daniel Allen',TO_DATE('2002-05-10','YYYY-MM-DD'),'F',5432109876,'65 Oak St, Village','O+',2021,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Henry','Wright','Jason Wright',TO_DATE('2001-11-30','YYYY-MM-DD'),'M',4321098765,'88 Cedar Blvd, Cityland','A-',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Lily','Scott','Steven Scott',TO_DATE('2000-03-13','YYYY-MM-DD'),'F',3210987654,'20 Fir Ave, District','B+',2022,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Aiden','Young','Joshua Young',TO_DATE('2000-04-29','YYYY-MM-DD'),'M',2109876543,'45 Pine Street, Citycenter','O-',2021,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Madison','Harris','Robert Harris',TO_DATE('1999-12-14','YYYY-MM-DD'),'F',1098765432,'5 Cedar Road, Cityville','AB-',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Ethan','Thompson','Andrew Thompson',TO_DATE('2002-10-01','YYYY-MM-DD'),'M',9878909876,'12 Maple Ave, Hamlet','A+',2021,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Grayson','Green','Michael Green',TO_DATE('2000-01-25','YYYY-MM-DD'),'M',8765432101,'76 Birch St, Citytown','B+',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Victoria','Moore','Paul Moore',TO_DATE('2001-07-07','YYYY-MM-DD'),'F',7654321090,'44 Pine Blvd, Townsville','O-',2022,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Jackson','Hall','Jacob Hall',TO_DATE('2000-11-16','YYYY-MM-DD'),'M',6543210989,'21 Elm Road, Hamlet','AB+',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Sophia','Taylor','William Taylor',TO_DATE('2001-06-30','YYYY-MM-DD'),'F',5432109878,'92 Cedar Avenue, Village','A-',2021,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Sebastian','Clark','Charles Clark',TO_DATE('2002-03-10','YYYY-MM-DD'),'M',4321098767,'60 Maple Blvd, Citycenter','B-',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Ava','Rodriguez','Anthony Rodriguez',TO_DATE('1999-08-22','YYYY-MM-DD'),'F',3210987656,'34 Fir St, Cityville','O+',2022,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Logan','Lewis','David Lewis',TO_DATE('2001-05-10','YYYY-MM-DD'),'M',9876543210,'60 Cedar Blvd, Cityville','A+',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Emma','Martinez','Frank Martinez',TO_DATE('1999-01-15','YYYY-MM-DD'),'F',8765432109,'33 Pine Street, Townsville','B-',2021,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Mason','Perez','Robert Perez',TO_DATE('2000-06-30','YYYY-MM-DD'),'M',7654321098,'8 Maple Lane, Citytown','O+',2022,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Scarlett','Johnson','Charles Johnson',TO_DATE('2000-09-20','YYYY-MM-DD'),'F',6543210987,'25 Oak Ave, Hamlet','AB-',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Liam','Smith','Thomas Smith',TO_DATE('2002-04-05','YYYY-MM-DD'),'M',5432109876,'48 Birch Blvd, Village','A-',2021,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Chloe','Taylor','Mark Taylor',TO_DATE('1999-07-25','YYYY-MM-DD'),'F',4321098765,'22 Cedar St, Cityland','B+',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Jackson','Walker','Joshua Walker',TO_DATE('2001-12-15','YYYY-MM-DD'),'M',3210987654,'69 Fir Ave, Citycenter','O-',2022,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Olivia','Hernandez','Jason Hernandez',TO_DATE('2000-10-10','YYYY-MM-DD'),'F',2109876543,'18 Maple St, District','AB+',2021,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Daniel','Young','Jacob Young',TO_DATE('2001-03-08','YYYY-MM-DD'),'M',1098765432,'47 Pine Rd, Cityville','A+',2020,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Ava','King','William King',TO_DATE('1999-04-18','YYYY-MM-DD'),'F',9878909876,'20 Cedar Ave, Hamlet','B-',2021,'B31MrIaThC302','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT 'Harper','Lopez','Anthony Lopez',TO_DATE('2000-02-14','YYYY-MM-DD'),'F',8765432101,'37 Birch Lane, Townsville','O+',2022,'B31MrIaThC302','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Lucas','Scott','David Scott',TO_DATE('2001-05-15','YYYY-MM-DD'),'M',7654321090,'15 Oak St, Citypoint','AB-',2020,'B31MrIaThC302','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Benjamin','Gonzalez','Charles Gonzalez',TO_DATE('2000-12-30','YYYY-MM-DD'),'M',6543210989,'70 Maple Blvd, Citycenter','A-',2021,'B31MrIaThC302','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Ella','Ramirez','Joseph Ramirez',TO_DATE('2002-11-18','YYYY-MM-DD'),'F',5432109878,'13 Cedar Rd, District','B+',2020,'B31MrIaThC302','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Nathan','Cooper','Edward Cooper',TO_DATE('1999-06-20','YYYY-MM-DD'),'M',4321098767,'30 Oak Ave, Cityland','O-',2021,'B31MrIaThC302','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Mia','Reed','Robert Reed',TO_DATE('2000-08-25','YYYY-MM-DD'),'F',3210987656,'55 Birch Blvd, Hamlet','AB+',2022,'B31MrIaThC302','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Isabella','Wright','David Wright',TO_DATE('2001-05-17','YYYY-MM-DD'),'F',9876543210,'40 Oak Street, Cityville','O+',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Matthew','Brooks','Anthony Brooks',TO_DATE('1999-09-09','YYYY-MM-DD'),'M',8765432109,'29 Maple Ave, Townsville','A-',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Sophia','Reed','Robert Reed',TO_DATE('2000-04-25','YYYY-MM-DD'),'F',7654321098,'64 Birch Lane, Citytown','B+',2022,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Jacob','Cooper','William Cooper',TO_DATE('2000-10-14','YYYY-MM-DD'),'M',6543210987,'55 Cedar Blvd, Hamlet','AB-',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Ava','Carter','Joseph Carter',TO_DATE('2001-01-30','YYYY-MM-DD'),'F',5432109876,'15 Elm Street, Cityland','O-',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Elijah','Harris','James Harris',TO_DATE('2002-08-05','YYYY-MM-DD'),'M',4321098765,'89 Fir Rd, Village','A+',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Mia','Hall','Charles Hall',TO_DATE('1999-12-12','YYYY-MM-DD'),'F',3210987654,'23 Pine Ave, District','B-',2022,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Lucas','Adams','Thomas Adams',TO_DATE('2000-06-18','YYYY-MM-DD'),'M',2109876543,'78 Oak Boulevard, Citypoint','AB+',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Harper','Bennett','Edward Bennett',TO_DATE('2001-11-15','YYYY-MM-DD'),'F',1098765432,'12 Maple Lane, Cityville','O+',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'James','Garcia','Frank Garcia',TO_DATE('2000-03-24','YYYY-MM-DD'),'M',9878909876,'91 Cedar St, Townsville','A-',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Charlotte','Lopez','Daniel Lopez',TO_DATE('2002-02-05','YYYY-MM-DD'),'F',8765432101,'34 Birch Ave, Hamlet','B+',2022,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Henry','Parker','Anthony Parker',TO_DATE('2001-07-29','YYYY-MM-DD'),'M',7654321090,'54 Elm Rd, Cityland','O-',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Evelyn','Turner','Joshua Turner',TO_DATE('1999-08-01','YYYY-MM-DD'),'F',6543210989,'76 Fir St, Citypoint','AB-',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Nathan','Rivera','Robert Rivera',TO_DATE('2000-12-23','YYYY-MM-DD'),'M',5432109878,'35 Cedar Blvd, District','A+',2022,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Scarlett','Hall','Michael Hall',TO_DATE('2000-05-09','YYYY-MM-DD'),'F',4321098767,'61 Oak Ave, Citycenter','B-',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Gabriel','Scott','Charles Scott',TO_DATE('2001-10-30','YYYY-MM-DD'),'M',3210987656,'83 Maple St, Cityville','O+',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Ava','Johnson','Anthony Johnson',TO_DATE('2001-02-16','YYYY-MM-DD'),'F',9876543210,'45 Birch Lane, Cityville','O-',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Lucas','Lee','Charles Lee',TO_DATE('1999-06-30','YYYY-MM-DD'),'M',8765432109,'82 Pine Blvd, Townsville','A+',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Mia','White','Frank White',TO_DATE('2000-04-12','YYYY-MM-DD'),'F',7654321098,'61 Maple St, Citytown','B-',2022,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Samuel','Harris','Robert Harris',TO_DATE('2000-08-25','YYYY-MM-DD'),'M',6543210987,'32 Elm Rd, Hamlet','AB+',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Emma','Martinez','Edward Martinez',TO_DATE('2001-11-05','YYYY-MM-DD'),'F',5432109876,'19 Cedar Blvd, Cityland','O+',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Noah','Brown','Anthony Brown',TO_DATE('2002-01-21','YYYY-MM-DD'),'M',4321098765,'26 Oak St, Village','A-',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Jackson','Young','Joshua Young',TO_DATE('2000-12-14','YYYY-MM-DD'),'M',3210987654,'7 Birch Lane, District','B+',2022,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Grace','Scott','William Scott',TO_DATE('1999-03-17','YYYY-MM-DD'),'F',2109876543,'13 Maple Ave, Citycenter','AB-',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Ethan','Hall','Michael Hall',TO_DATE('2001-09-30','YYYY-MM-DD'),'M',1098765432,'88 Pine St, Hamlet','O+',2020,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Charlotte','Perez','Thomas Perez',TO_DATE('2000-05-11','YYYY-MM-DD'),'F',9878909876,'72 Fir Blvd, Citypoint','A-',2021,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'William','Adams','James Adams',TO_DATE('2001-10-09','YYYY-MM-DD'),'M',8765432101,'57 Cedar Rd, Cityville','B-',2022,'C29PrJeClC303','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Lily','Lewis','Robert Lewis',TO_DATE('2000-12-18','YYYY-MM-DD'),'F',7654321090,'10 Oak Blvd, Townsville','O+',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Benjamin','Walker','Edward Walker',TO_DATE('2002-06-27','YYYY-MM-DD'),'M',6543210989,'54 Birch St, Cityland','AB+',2021,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Harper','Martinez','Charles Martinez',TO_DATE('1999-07-14','YYYY-MM-DD'),'F',5432109878,'30 Cedar Ave, Hamlet','A-',2022,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Logan','Wilson','Paul Wilson',TO_DATE('2001-04-15','YYYY-MM-DD'),'M',4321098767,'41 Maple Blvd, Citypoint','B+',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Scarlett','King','Anthony King',TO_DATE('2000-03-27','YYYY-MM-DD'),'F',3210987656,'80 Pine Rd, District','O-',2021,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Elijah','Green','Robert Green',TO_DATE('2001-10-20','YYYY-MM-DD'),'M',9876543210,'44 Cedar Lane, Cityville','O+',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Hannah','Wright','Anthony Wright',TO_DATE('1999-09-02','YYYY-MM-DD'),'F',8765432109,'72 Pine Blvd, Townsville','A-',2021,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Aiden','Lewis','William Lewis',TO_DATE('2000-05-05','YYYY-MM-DD'),'M',7654321098,'3 Birch St, Citytown','B+',2022,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Grace','Hall','Charles Hall',TO_DATE('2002-04-09','YYYY-MM-DD'),'F',6543210987,'88 Elm Ave, Hamlet','AB-',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Chloe','Taylor','Thomas Taylor',TO_DATE('2001-11-11','YYYY-MM-DD'),'F',5432109876,'25 Maple Blvd, Cityland','O-',2021,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Logan','Scott','Robert Scott',TO_DATE('2000-01-14','YYYY-MM-DD'),'M',4321098765,'90 Cedar Rd, District','A+',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Oliver','Johnson','David Johnson',TO_DATE('2002-07-03','YYYY-MM-DD'),'M',3210987654,'56 Birch Blvd, Citypoint','B-',2022,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Sofia','Adams','James Adams',TO_DATE('1999-06-24','YYYY-MM-DD'),'F',2109876543,'37 Oak Ave, Cityville','AB+',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Ava','Turner','Charles Turner',TO_DATE('2000-09-16','YYYY-MM-DD'),'F',1098765432,'45 Maple St, Townsville','O+',2021,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Henry','Williams','Anthony Williams',TO_DATE('2002-12-08','YYYY-MM-DD'),'M',9878909876,'12 Cedar Blvd, Hamlet','A-',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Mia','King','Robert King',TO_DATE('2001-03-27','YYYY-MM-DD'),'F',8765432101,'38 Oak St, Citycenter','B+',2021,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Jackson','Martin','William Martin',TO_DATE('2000-08-12','YYYY-MM-DD'),'M',7654321090,'59 Pine Rd, District','O-',2022,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Amelia','Harris','Thomas Harris',TO_DATE('2000-02-14','YYYY-MM-DD'),'F',6543210989,'70 Elm Blvd, Citypoint','AB-',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Elijah','Scott','Edward Scott',TO_DATE('2001-05-21','YYYY-MM-DD'),'M',5432109878,'16 Fir St, Cityville','A+',2021,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Lucas','Carter','Paul Carter',TO_DATE('2002-01-30','YYYY-MM-DD'),'M',4321098767,'98 Maple Ave, Townsville','B-',2022,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Harper','Wright','Robert Wright',TO_DATE('2000-03-02','YYYY-MM-DD'),'F',3210987656,'47 Oak Blvd, District','O+',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Noah','Adams','Michael Adams',TO_DATE('2000-10-15','YYYY-MM-DD'),'M',9876543210,'56 Maple St, Cityville','A-',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Isabella','Hall','Robert Hall',TO_DATE('2001-05-30','YYYY-MM-DD'),'F',8765432109,'72 Elm St, Townsville','O+',2021,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Elijah','Clark','David Clark',TO_DATE('1999-09-22','YYYY-MM-DD'),'M',7654321098,'89 Birch Ave, Cityland','B-',2022,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Mia','Brown','Edward Brown',TO_DATE('2000-07-18','YYYY-MM-DD'),'F',6543210987,'34 Oak Rd, Hamlet','AB+',2020,'B27DrZaCoD402','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'William','Harris','Charles Harris',TO_DATE('2002-11-12','YYYY-MM-DD'),'M',5432109876,'23 Cedar Blvd, Citypoint','O-',2021,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Emma','King','Anthony King',TO_DATE('2001-06-25','YYYY-MM-DD'),'F',4321098765,'15 Maple Ln, Cityville','A+',2022,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Jackson','Lewis','Robert Lewis',TO_DATE('1999-03-09','YYYY-MM-DD'),'M',3210987654,'88 Pine Blvd, Townsville','B+',2020,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Grace','Scott','James Scott',TO_DATE('2001-12-01','YYYY-MM-DD'),'F',2109876543,'62 Cedar Rd, Hamlet','AB-',2021,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Samuel','Turner','Joshua Turner',TO_DATE('2000-08-19','YYYY-MM-DD'),'M',1098765432,'4 Oak St, Citycenter','O+',2022,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Harper','Wright','Thomas Wright',TO_DATE('2002-01-11','YYYY-MM-DD'),'F',9878909876,'36 Fir Ave, Cityville','A-',2020,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Benjamin','Miller','Edward Miller',TO_DATE('2000-04-15','YYYY-MM-DD'),'M',8765432101,'49 Birch Ln, Citypoint','B-',2021,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Scarlett','Robinson','Anthony Robinson',TO_DATE('1999-02-28','YYYY-MM-DD'),'F',7654321090,'90 Maple Rd, Hamlet','AB+',2022,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Lucas','Rodriguez','Michael Rodriguez',TO_DATE('2001-07-05','YYYY-MM-DD'),'M',6543210989,'14 Oak Ave, Townsville','O+',2020,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Chloe','Martinez','William Martinez',TO_DATE('2000-05-14','YYYY-MM-DD'),'F',5432109878,'57 Pine Blvd, Cityland','A-',2021,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Daniel','Lee','Charles Lee',TO_DATE('2001-09-18','YYYY-MM-DD'),'M',4321098767,'82 Fir St, Citycenter','B+',2022,'C23DrOsMaD403','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT 'Lily','Gonzalez','David Gonzalez',TO_DATE('1999-11-10','YYYY-MM-DD'),'F',3210987656,'31 Elm Blvd, District','AB-',2020,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Jacob','Evans','Robert Evans',TO_DATE('2000-12-05','YYYY-MM-DD'),'M',9876543210,'67 Pine Ave, Cityville','O+',2020,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Ella','Lee','Charles Lee',TO_DATE('2001-06-17','YYYY-MM-DD'),'F',8765432109,'84 Birch Ln, Townsville','A-',2021,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Michael','Johnson','David Johnson',TO_DATE('1999-07-23','YYYY-MM-DD'),'M',7654321098,'39 Elm Blvd, Cityland','B+',2022,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Amelia','Wilson','Anthony Wilson',TO_DATE('2000-09-04','YYYY-MM-DD'),'F',6543210987,'11 Cedar Rd, Hamlet','AB-',2020,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Ethan','Hall','Edward Hall',TO_DATE('2002-05-26','YYYY-MM-DD'),'M',5432109876,'73 Oak Blvd, Citypoint','O-',2021,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Hannah','Taylor','Joshua Taylor',TO_DATE('2001-03-29','YYYY-MM-DD'),'F',4321098765,'54 Maple St, District','A+',2022,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Oliver','Miller','Robert Miller',TO_DATE('1999-10-15','YYYY-MM-DD'),'M',3210987654,'36 Fir Rd, Cityville','B-',2020,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Chloe','Lopez','William Lopez',TO_DATE('2000-02-12','YYYY-MM-DD'),'F',2109876543,'81 Pine Blvd, Townsville','AB+',2021,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Benjamin','Martinez','Thomas Martinez',TO_DATE('2001-11-18','YYYY-MM-DD'),'M',1098765432,'22 Cedar Ave, Cityland','O+',2022,'C23DrOsMaD403','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Grace','Walker','Michael Walker',TO_DATE('2002-01-01','YYYY-MM-DD'),'F',9878909876,'60 Birch St, Hamlet','A-',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Samuel','Brown','Edward Brown',TO_DATE('1999-08-17','YYYY-MM-DD'),'M',8765432101,'50 Elm Blvd, Citypoint','B+',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Emma','Garcia','Robert Garcia',TO_DATE('2001-04-30','YYYY-MM-DD'),'F',7654321090,'44 Oak Rd, Cityville','AB-',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Daniel','Thomas','Joshua Thomas',TO_DATE('2002-03-26','YYYY-MM-DD'),'M',6543210989,'91 Cedar St, Townsville','O+',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Lily','Rodriguez','Charles Rodriguez',TO_DATE('2000-12-02','YYYY-MM-DD'),'F',5432109878,'29 Maple Rd, Hamlet','A-',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Elijah','Smith','Anthony Smith',TO_DATE('2000-06-14','YYYY-MM-DD'),'M',4321098767,'15 Fir Blvd, Citycenter','B+',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Harper','Young','David Young',TO_DATE('1999-09-19','YYYY-MM-DD'),'F',3210987656,'86 Pine St, Cityland','AB-',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Olivia','King','James King',TO_DATE('2000-05-15','YYYY-MM-DD'),'F',9876543210,'92 Maple Blvd, Citypoint','O+',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Elijah','Nelson','Charles Nelson',TO_DATE('1999-11-11','YYYY-MM-DD'),'M',8765432109,'12 Pine Rd, Cityland','A-',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Grace','Carter','Edward Carter',TO_DATE('2001-03-30','YYYY-MM-DD'),'F',7654321098,'76 Elm Blvd, Townsville','B-',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Noah','Brown','David Brown',TO_DATE('2002-07-18','YYYY-MM-DD'),'M',6543210987,'45 Cedar St, Hamlet','AB+',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Mia','Hill','Joshua Hill',TO_DATE('2000-09-09','YYYY-MM-DD'),'F',5432109876,'30 Fir Ave, District','O-',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Lucas','Mitchell','Thomas Mitchell',TO_DATE('2001-12-23','YYYY-MM-DD'),'M',4321098765,'21 Maple St, Citycenter','A+',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Charlotte','Wood','William Wood',TO_DATE('1999-08-28','YYYY-MM-DD'),'F',3210987654,'55 Oak Ln, Cityville','B+',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Jackson','Lee','Robert Lee',TO_DATE('2000-01-05','YYYY-MM-DD'),'M',2109876543,'39 Cedar Ave, Townsville','AB-',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Lily','Rivera','David Rivera',TO_DATE('2002-04-19','YYYY-MM-DD'),'F',1098765432,'49 Birch Blvd, Hamlet','O+',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Daniel','Parker','Anthony Parker',TO_DATE('2000-10-10','YYYY-MM-DD'),'M',9878909876,'99 Fir St, Cityland','A-',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Scarlett','Turner','Charles Turner',TO_DATE('2001-07-30','YYYY-MM-DD'),'F',8765432101,'63 Maple Rd, Citypoint','B-',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Benjamin','Davis','Edward Davis',TO_DATE('1999-02-12','YYYY-MM-DD'),'M',7654321090,'11 Oak Blvd, District','AB+',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Amelia','Johnson','Robert Johnson',TO_DATE('2000-12-15','YYYY-MM-DD'),'F',6543210989,'75 Pine Ave, Cityville','O+',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Elijah','Martinez','Thomas Martinez',TO_DATE('2002-01-18','YYYY-MM-DD'),'M',5432109878,'48 Cedar St, Cityland','A-',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Ava','Roberts','Joshua Roberts',TO_DATE('2000-09-22','YYYY-MM-DD'),'F',4321098767,'85 Elm Blvd, Townsville','B+',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Samuel','Green','Michael Green',TO_DATE('1999-11-25','YYYY-MM-DD'),'M',3210987656,'8 Oak Rd, Hamlet','AB-',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Alexander','Carter','Robert Carter',TO_DATE('2000-05-01','YYYY-MM-DD'),'M',9876543210,'45 Pine St, Cityville','O+',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Sophia','Davis','Edward Davis',TO_DATE('1999-09-12','YYYY-MM-DD'),'F',8765432109,'23 Maple Blvd, Townsville','A-',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Noah','Miller','Anthony Miller',TO_DATE('2001-04-19','YYYY-MM-DD'),'M',7654321098,'68 Elm Ave, Cityland','B+',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Isabella','Anderson','Joshua Anderson',TO_DATE('2002-01-24','YYYY-MM-DD'),'F',6543210987,'78 Cedar Rd, Hamlet','AB-',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Ethan','Johnson','William Johnson',TO_DATE('2000-12-11','YYYY-MM-DD'),'M',5432109876,'34 Fir St, Citypoint','O-',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Mia','Robinson','Charles Robinson',TO_DATE('2001-08-28','YYYY-MM-DD'),'F',4321098765,'56 Birch Blvd, District','A+',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Liam','Wilson','Michael Wilson',TO_DATE('2002-03-15','YYYY-MM-DD'),'M',3210987654,'90 Maple Ln, Cityville','B-',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Amelia','Lee','David Lee',TO_DATE('2000-11-30','YYYY-MM-DD'),'F',2109876543,'19 Oak Blvd, Townsville','AB+',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Lucas','Thomas','Robert Thomas',TO_DATE('2001-07-05','YYYY-MM-DD'),'M',1098765432,'43 Cedar St, Cityland','O+',2022,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Chloe','Martinez','Anthony Martinez',TO_DATE('1999-10-20','YYYY-MM-DD'),'F',9878909876,'29 Elm Rd, Hamlet','A-',2020,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Benjamin','White','Edward White',TO_DATE('2000-06-29','YYYY-MM-DD'),'M',8765432101,'8 Fir Ave, Citycenter','B+',2021,'A36DrUmRoE501','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Grace','Jackson','Joshua Jackson',TO_DATE('2001-05-12','YYYY-MM-DD'),'F',7654321090,'65 Pine St, Cityville','AB-',2022,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Samuel','Harris','Charles Harris',TO_DATE('2002-02-04','YYYY-MM-DD'),'M',6543210989,'22 Birch Blvd, Townsville','O+',2020,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Lily','Martin','Robert Martin',TO_DATE('2000-08-16','YYYY-MM-DD'),'F',5432109878,'50 Maple St, Hamlet','A-',2021,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Elijah','Thompson','Michael Thompson',TO_DATE('2001-09-30','YYYY-MM-DD'),'M',4321098767,'91 Elm Ave, Citypoint','B+',2022,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Harper','Garcia','David Garcia',TO_DATE('1999-03-18','YYYY-MM-DD'),'F',3210987656,'77 Cedar Rd, Cityland','AB-',2020,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Olivia','King','James King',TO_DATE('2000-03-14','YYYY-MM-DD'),'F',9876543210,'67 Maple Blvd, Citypoint','O+',2020,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Elijah','Nelson','Charles Nelson',TO_DATE('1999-04-11','YYYY-MM-DD'),'M',8765432109,'22 Pine Rd, Cityland','A-',2021,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Grace','Carter','Edward Carter',TO_DATE('2001-07-30','YYYY-MM-DD'),'F',7654321098,'13 Elm Blvd, Townsville','B-',2022,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Noah','Brown','David Brown',TO_DATE('2002-05-05','YYYY-MM-DD'),'M',6543210987,'89 Cedar St, Hamlet','AB+',2020,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Mia','Hill','Joshua Hill',TO_DATE('2000-10-09','YYYY-MM-DD'),'F',5432109876,'50 Fir Ave, District','O-',2021,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Lucas','Mitchell','Thomas Mitchell',TO_DATE('2001-12-21','YYYY-MM-DD'),'M',4321098765,'35 Maple St, Citycenter','A+',2022,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Charlotte','Wood','William Wood',TO_DATE('1999-08-12','YYYY-MM-DD'),'F',3210987654,'40 Oak Ln, Cityville','B+',2020,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Jackson','Lee','Robert Lee',TO_DATE('2000-02-03','YYYY-MM-DD'),'M',2109876543,'99 Cedar Ave, Townsville','AB-',2021,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Lily','Rivera','David Rivera',TO_DATE('2002-01-19','YYYY-MM-DD'),'F',1098765432,'52 Birch Blvd, Hamlet','O+',2022,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Daniel','Parker','Anthony Parker',TO_DATE('2000-10-14','YYYY-MM-DD'),'M',9878909876,'18 Fir St, Cityland','A-',2020,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Scarlett','Turner','Charles Turner',TO_DATE('2001-09-01','YYYY-MM-DD'),'F',8765432101,'66 Maple Rd, Citypoint','B-',2021,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Benjamin','Davis','Edward Davis',TO_DATE('1999-06-11','YYYY-MM-DD'),'M',7654321090,'31 Oak Blvd, District','AB+',2022,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Amelia','Johnson','Robert Johnson',TO_DATE('2000-11-24','YYYY-MM-DD'),'F',6543210989,'26 Pine Ave, Cityville','O+',2020,'C20DrOsMaE503','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Elijah','Martinez','Thomas Martinez',TO_DATE('2002-02-20','YYYY-MM-DD'),'M',5432109878,'71 Cedar St, Cityland','A-',2021,'A32PrKaMoF601','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Ava','Roberts','Joshua Roberts',TO_DATE('2000-03-22','YYYY-MM-DD'),'F',4321098767,'84 Elm Blvd, Townsville','B+',2022,'A32PrKaMoF601','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Samuel','Green','Michael Green',TO_DATE('1999-11-09','YYYY-MM-DD'),'M',3210987656,'64 Oak Rd, Hamlet','AB-',2020,'A32PrKaMoF601','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Grace','White','James White',TO_DATE('2000-06-15','YYYY-MM-DD'),'F',9876543210,'88 Maple St, Citycenter','O+',2020,'A32PrKaMoF601','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'William','Lewis','Charles Lewis',TO_DATE('1999-09-14','YYYY-MM-DD'),'M',8765432109,'44 Elm Rd, Townsville','A-',2021,'A32PrKaMoF601','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Lily','Carter','Anthony Carter',TO_DATE('2001-03-20','YYYY-MM-DD'),'F',7654321098,'77 Fir Blvd, Hamlet','B+',2022,'A32PrKaMoF601','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Jackson','Hall','Robert Hall',TO_DATE('2002-11-30','YYYY-MM-DD'),'M',6543210987,'19 Cedar Ave, Cityland','AB-',2020,'A32PrKaMoF601','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Noah','Martinez','David Martinez',TO_DATE('2000-10-09','YYYY-MM-DD'),'M',5432109876,'55 Pine Blvd, Citypoint','O-',2021,'A32PrKaMoF601','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT 'Emily','Young','Joshua Young',TO_DATE('2001-01-18','YYYY-MM-DD'),'F',4321098765,'61 Maple Ln, Hamlet','A+',2022,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Ethan','Robinson','Michael Robinson',TO_DATE('1999-07-25','YYYY-MM-DD'),'M',3210987654,'8 Birch Blvd, District','B-',2020,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Sophia','Davis','William Davis',TO_DATE('2000-12-12','YYYY-MM-DD'),'F',2109876543,'92 Oak Rd, Cityville','AB+',2021,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Elijah','Nelson','Edward Nelson',TO_DATE('2002-04-17','YYYY-MM-DD'),'M',1098765432,'25 Cedar St, Cityland','O+',2022,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Benjamin','Lee','Robert Lee',TO_DATE('1999-05-21','YYYY-MM-DD'),'M',9878909876,'58 Elm Ave, Hamlet','A-',2020,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Mia','Moore','Thomas Moore',TO_DATE('2000-09-06','YYYY-MM-DD'),'F',8765432101,'33 Pine Blvd, Citycenter','B+',2021,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Samuel','Scott','David Scott',TO_DATE('2001-06-04','YYYY-MM-DD'),'M',7654321090,'14 Oak Ln, Townsville','AB-',2022,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Ava','Hill','Anthony Hill',TO_DATE('2002-02-15','YYYY-MM-DD'),'F',6543210989,'86 Cedar Ave, Cityland','O+',2020,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Daniel','Thomas','James Thomas',TO_DATE('2000-10-24','YYYY-MM-DD'),'M',5432109878,'12 Elm Blvd, Citypoint','A-',2021,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Chloe','Martinez','Joshua Martinez',TO_DATE('2001-03-30','YYYY-MM-DD'),'F',4321098767,'70 Fir Ave, Hamlet','B+',2022,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Lucas','Gonzalez','Michael Gonzalez',TO_DATE('1999-08-11','YYYY-MM-DD'),'M',3210987656,'48 Maple Rd, Cityville','AB-',2020,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Liam','Harris','Robert Harris',TO_DATE('2000-05-02','YYYY-MM-DD'),'M',9876543210,'34 Elm St, Cityville','O+',2020,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Emma','Johnson','Charles Johnson',TO_DATE('1999-03-15','YYYY-MM-DD'),'F',8765432109,'45 Pine Blvd, Townsville','A-',2021,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Noah','Wilson','James Wilson',TO_DATE('2001-11-22','YYYY-MM-DD'),'M',7654321098,'67 Maple Ave, Cityland','B+',2022,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Ava','Brown','Joshua Brown',TO_DATE('2002-02-14','YYYY-MM-DD'),'F',6543210987,'12 Birch Rd, Hamlet','AB-',2020,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Ethan','Garcia','William Garcia',TO_DATE('2000-09-08','YYYY-MM-DD'),'M',5432109876,'90 Cedar St, Citypoint','O-',2021,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Isabella','Martinez','Anthony Martinez',TO_DATE('2001-06-30','YYYY-MM-DD'),'F',4321098765,'78 Fir Blvd, Citycenter','A+',2022,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Lucas','Lee','David Lee',TO_DATE('2002-04-05','YYYY-MM-DD'),'M',3210987654,'23 Oak Ln, Cityville','B-',2020,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Sophia','Thompson','Robert Thompson',TO_DATE('1999-12-18','YYYY-MM-DD'),'F',2109876543,'44 Elm St, Townsville','AB+',2021,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Benjamin','Hall','Michael Hall',TO_DATE('2000-08-11','YYYY-MM-DD'),'M',1098765432,'89 Maple Rd, Hamlet','O+',2022,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Mia','Clark','Charles Clark',TO_DATE('2001-10-25','YYYY-MM-DD'),'F',9878909876,'56 Birch Blvd, Cityland','A-',2020,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Samuel','Rodriguez','Edward Rodriguez',TO_DATE('2002-03-14','YYYY-MM-DD'),'M',8765432101,'21 Cedar Ave, Citycenter','B+',2021,'A32PrKaMoF601','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Chloe','Lewis','Thomas Lewis',TO_DATE('2000-05-09','YYYY-MM-DD'),'F',7654321090,'76 Oak Rd, Hamlet','AB-',2022,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Jackson','Young','Joshua Young',TO_DATE('2001-07-16','YYYY-MM-DD'),'M',6543210989,'11 Fir St, Citypoint','O+',2020,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Grace','Hernandez','Anthony Hernandez',TO_DATE('1999-01-01','YYYY-MM-DD'),'F',5432109878,'42 Maple Blvd, Townsville','A-',2021,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Elijah','King','Michael King',TO_DATE('2002-12-05','YYYY-MM-DD'),'M',4321098767,'31 Cedar Rd, Cityland','B+',2022,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Harper','Allen','David Allen',TO_DATE('2000-11-13','YYYY-MM-DD'),'F',3210987656,'65 Elm Ave, Hamlet','AB-',2020,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'William','Wright','Robert Wright',TO_DATE('2000-03-07','YYYY-MM-DD'),'M',9876543210,'40 Maple St, Citycenter','O+',2020,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Amelia','Scott','Charles Scott',TO_DATE('1999-05-14','YYYY-MM-DD'),'F',8765432109,'22 Elm Rd, Townsville','A-',2021,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Daniel','Hill','James Hill',TO_DATE('2001-09-23','YYYY-MM-DD'),'M',7654321098,'55 Birch Blvd, Hamlet','B+',2022,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Sophia','Torres','Joshua Torres',TO_DATE('2002-01-12','YYYY-MM-DD'),'F',6543210987,'33 Cedar St, Cityland','AB-',2020,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Elijah','Lee','Edward Lee',TO_DATE('2000-12-04','YYYY-MM-DD'),'M',5432109876,'76 Pine Blvd, Citypoint','O-',2021,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Isabella','Rivera','Anthony Rivera',TO_DATE('2001-06-21','YYYY-MM-DD'),'F',4321098765,'14 Oak Ln, Hamlet','A+',2022,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Lucas','Davis','David Davis',TO_DATE('2002-10-29','YYYY-MM-DD'),'M',3210987654,'9 Elm Blvd, Cityville','B-',2020,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Mia','Martinez','Robert Martinez',TO_DATE('1999-02-26','YYYY-MM-DD'),'F',2109876543,'87 Cedar Ave, Townsville','AB+',2021,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Jackson','Garcia','Charles Garcia',TO_DATE('2000-08-15','YYYY-MM-DD'),'M',1098765432,'72 Birch Blvd, Hamlet','O+',2022,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Grace','Lopez','Thomas Lopez',TO_DATE('2001-11-30','YYYY-MM-DD'),'F',9878909876,'25 Fir Rd, Cityland','A-',2020,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Benjamin','Johnson','Anthony Johnson',TO_DATE('2002-04-10','YYYY-MM-DD'),'M',8765432101,'44 Maple St, Citycenter','B+',2021,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Chloe','Lee','Joshua Lee',TO_DATE('1999-07-19','YYYY-MM-DD'),'F',7654321090,'12 Oak Ave, Hamlet','AB-',2022,'B19DrXeNeF602','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Samuel','Martinez','Michael Martinez',TO_DATE('2000-09-28','YYYY-MM-DD'),'M',6543210989,'53 Cedar Rd, Citypoint','O+',2020,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Ava','Anderson','Robert Anderson',TO_DATE('2001-05-25','YYYY-MM-DD'),'F',5432109878,'19 Fir Blvd, Townsville','A-',2021,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Noah','Thompson','David Thompson',TO_DATE('2002-02-18','YYYY-MM-DD'),'M',4321098767,'60 Maple St, Cityville','B+',2022,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Lily','Robinson','James Robinson',TO_DATE('2000-01-07','YYYY-MM-DD'),'F',3210987656,'8 Elm Rd, Hamlet','AB-',2020,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Mia','Parker','Robert Parker',TO_DATE('2000-04-01','YYYY-MM-DD'),'F',9876543210,'34 Maple St, Citypoint','O+',2020,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Alexander','Evans','Charles Evans',TO_DATE('1999-06-12','YYYY-MM-DD'),'M',8765432109,'45 Elm Blvd, Townsville','A-',2021,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Benjamin','Walker','James Walker',TO_DATE('2001-08-19','YYYY-MM-DD'),'M',7654321098,'67 Birch Rd, Cityland','B+',2022,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Grace','Gonzalez','Joshua Gonzalez',TO_DATE('2002-12-30','YYYY-MM-DD'),'F',6543210987,'12 Cedar St, Hamlet','AB-',2020,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Noah','Hall','William Hall',TO_DATE('2000-11-17','YYYY-MM-DD'),'M',5432109876,'90 Fir Blvd, Citycenter','O-',2021,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Olivia','Lee','Anthony Lee',TO_DATE('2001-09-22','YYYY-MM-DD'),'F',4321098765,'78 Pine Ave, Cityville','A+',2022,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Lucas','Martinez','David Martinez',TO_DATE('2002-02-03','YYYY-MM-DD'),'M',3210987654,'23 Maple Rd, Cityland','B-',2020,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Isabella','Rodriguez','Michael Rodriguez',TO_DATE('1999-10-10','YYYY-MM-DD'),'F',2109876543,'44 Elm St, Townsville','AB+',2021,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Samuel','Davis','Charles Davis',TO_DATE('2000-07-26','YYYY-MM-DD'),'M',1098765432,'89 Birch Blvd, Hamlet','O+',2022,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Emma','Thomas','Thomas Thomas',TO_DATE('2001-05-14','YYYY-MM-DD'),'F',9878909876,'56 Fir Rd, Citypoint','A-',2020,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Jackson','Johnson','Joshua Johnson',TO_DATE('2002-03-12','YYYY-MM-DD'),'M',8765432101,'21 Cedar Blvd, Cityland','B+',2021,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Ava','Wilson','Edward Wilson',TO_DATE('2000-01-01','YYYY-MM-DD'),'F',7654321090,'76 Maple St, Hamlet','AB-',2022,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Elijah','Brown','William Brown',TO_DATE('2001-04-09','YYYY-MM-DD'),'M',6543210989,'11 Oak Ave, Citycenter','O+',2020,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Sophia','Martin','Robert Martin',TO_DATE('1999-08-05','YYYY-MM-DD'),'F',5432109878,'42 Birch Blvd, Townsville','A-',2021,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Liam','Lewis','James Lewis',TO_DATE('2002-11-11','YYYY-MM-DD'),'M',4321098767,'31 Cedar Rd, Cityland','B+',2022,'C21PrWaCrF603','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Chloe','Hernandez','Anthony Hernandez',TO_DATE('2000-12-20','YYYY-MM-DD'),'F',3210987656,'65 Elm Ave, Hamlet','AB-',2020,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'William','Wright','Robert Wright',TO_DATE('2000-05-01','YYYY-MM-DD'),'M',9876543210,'34 Maple St, Citypoint','O+',2020,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Olivia','Scott','Charles Scott',TO_DATE('1999-04-10','YYYY-MM-DD'),'F',8765432109,'45 Elm Rd, Townsville','A-',2021,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Daniel','Hill','James Hill',TO_DATE('2001-11-21','YYYY-MM-DD'),'M',7654321098,'67 Birch Blvd, Cityland','B+',2022,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Sophia','Torres','Joshua Torres',TO_DATE('2002-03-18','YYYY-MM-DD'),'F',6543210987,'12 Cedar St, Hamlet','AB-',2020,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Elijah','Lee','Edward Lee',TO_DATE('2000-07-09','YYYY-MM-DD'),'M',5432109876,'76 Pine Blvd, Citycenter','O-',2021,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Isabella','Rivera','Anthony Rivera',TO_DATE('2001-08-30','YYYY-MM-DD'),'F',4321098765,'78 Fir Ln, Cityville','A+',2022,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Lucas','Davis','David Davis',TO_DATE('2002-06-22','YYYY-MM-DD'),'M',3210987654,'23 Maple Rd, Cityland','B-',2020,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Mia','Martinez','Robert Martinez',TO_DATE('1999-10-14','YYYY-MM-DD'),'F',2109876543,'87 Cedar Ave, Townsville','AB+',2021,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Jackson','Garcia','Charles Garcia',TO_DATE('2000-12-06','YYYY-MM-DD'),'M',1098765432,'72 Birch Blvd, Hamlet','O+',2022,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Grace','Lopez','Thomas Lopez',TO_DATE('2001-09-01','YYYY-MM-DD'),'F',9878909876,'25 Fir Rd, Citycenter','A-',2020,'A26PrHaWiG701','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT 'Benjamin','Johnson','Joshua Johnson',TO_DATE('2002-02-17','YYYY-MM-DD'),'M',8765432101,'44 Maple St, Cityland','B+',2021,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Chloe','Lee','Michael Lee',TO_DATE('1999-01-21','YYYY-MM-DD'),'F',7654321090,'12 Oak Ave, Hamlet','AB-',2022,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Samuel','Martinez','Charles Martinez',TO_DATE('2000-11-29','YYYY-MM-DD'),'M',6543210989,'53 Cedar Rd, Citypoint','O+',2020,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Ava','Anderson','David Anderson',TO_DATE('2001-05-20','YYYY-MM-DD'),'F',5432109878,'19 Fir Blvd, Townsville','A-',2021,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Noah','Thompson','Edward Thompson',TO_DATE('2002-04-08','YYYY-MM-DD'),'M',4321098767,'60 Maple St, Cityville','B+',2022,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Lily','Robinson','Anthony Robinson',TO_DATE('2000-03-15','YYYY-MM-DD'),'F',3210987656,'8 Elm Rd, Hamlet','AB-',2020,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Mia','Turner','Robert Turner',TO_DATE('2000-04-11','YYYY-MM-DD'),'F',9876543210,'34 Maple St, Citypoint','O+',2020,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Alexander','Evans','Charles Evans',TO_DATE('1999-06-24','YYYY-MM-DD'),'M',8765432109,'45 Elm Rd, Townsville','A-',2021,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Benjamin','Walker','James Walker',TO_DATE('2001-09-05','YYYY-MM-DD'),'M',7654321098,'67 Birch Blvd, Cityland','B+',2022,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Grace','Gonzalez','Joshua Gonzalez',TO_DATE('2002-12-29','YYYY-MM-DD'),'F',6543210987,'12 Cedar St, Hamlet','AB-',2020,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Noah','Hall','William Hall',TO_DATE('2000-11-14','YYYY-MM-DD'),'M',5432109876,'90 Fir Blvd, Citycenter','O-',2021,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Olivia','Lee','Anthony Lee',TO_DATE('2001-07-10','YYYY-MM-DD'),'F',4321098765,'78 Pine Ave, Cityville','A+',2022,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Lucas','Martinez','David Martinez',TO_DATE('2002-02-24','YYYY-MM-DD'),'M',3210987654,'23 Maple Rd, Cityland','B-',2020,'A26PrHaWiG701','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Isabella','Rodriguez','Michael Rodriguez',TO_DATE('1999-10-17','YYYY-MM-DD'),'F',2109876543,'87 Cedar Ave, Townsville','AB+',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Samuel','Davis','Charles Davis',TO_DATE('2000-08-31','YYYY-MM-DD'),'M',1098765432,'72 Birch Blvd, Hamlet','O+',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Emma','Thomas','Thomas Thomas',TO_DATE('2001-03-12','YYYY-MM-DD'),'F',9878909876,'56 Fir Rd, Citypoint','A-',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Jackson','Johnson','Joshua Johnson',TO_DATE('2002-05-20','YYYY-MM-DD'),'M',8765432101,'21 Cedar Blvd, Cityland','B+',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Ava','Wilson','Edward Wilson',TO_DATE('2000-09-02','YYYY-MM-DD'),'F',7654321090,'76 Maple St, Hamlet','AB-',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Elijah','Brown','William Brown',TO_DATE('2001-10-29','YYYY-MM-DD'),'M',6543210989,'11 Oak Ave, Citycenter','O+',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Sophia','Martin','Robert Martin',TO_DATE('1999-08-06','YYYY-MM-DD'),'F',5432109878,'42 Birch Blvd, Townsville','A-',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Liam','Lewis','James Lewis',TO_DATE('2002-06-19','YYYY-MM-DD'),'M',4321098767,'31 Cedar Rd, Cityland','B+',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Chloe','Hernandez','Anthony Hernandez',TO_DATE('2000-12-12','YYYY-MM-DD'),'F',3210987656,'65 Elm Ave, Hamlet','AB-',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'James','Anderson','Robert Anderson',TO_DATE('2000-01-15','YYYY-MM-DD'),'M',9876543210,'34 Maple St, Citypoint','O+',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Charlotte','Martinez','Charles Martinez',TO_DATE('1999-09-25','YYYY-MM-DD'),'F',8765432109,'45 Elm Rd, Townsville','A-',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Daniel','Wilson','James Wilson',TO_DATE('2001-11-30','YYYY-MM-DD'),'M',7654321098,'67 Birch Blvd, Cityland','B+',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Sophia','Thomas','Joshua Thomas',TO_DATE('2002-03-11','YYYY-MM-DD'),'F',6543210987,'12 Cedar St, Hamlet','AB-',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Elijah','Young','Edward Young',TO_DATE('2000-05-05','YYYY-MM-DD'),'M',5432109876,'76 Pine Blvd, Citycenter','O-',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Isabella','Lee','Anthony Lee',TO_DATE('2001-10-17','YYYY-MM-DD'),'F',4321098765,'78 Fir Ln, Cityville','A+',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Lucas','Brown','David Brown',TO_DATE('2002-07-21','YYYY-MM-DD'),'M',3210987654,'23 Maple Rd, Cityland','B-',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Mia','Rodriguez','Michael Rodriguez',TO_DATE('1999-12-14','YYYY-MM-DD'),'F',2109876543,'87 Cedar Ave, Townsville','AB+',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Samuel','Garcia','Charles Garcia',TO_DATE('2000-02-28','YYYY-MM-DD'),'M',1098765432,'72 Birch Blvd, Hamlet','O+',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Emma','Martinez','Thomas Martinez',TO_DATE('2001-08-06','YYYY-MM-DD'),'F',9878909876,'56 Fir Rd, Citypoint','A-',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Jackson','Johnson','Joshua Johnson',TO_DATE('2002-11-21','YYYY-MM-DD'),'M',8765432101,'21 Cedar Blvd, Cityland','B+',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Ava','Wilson','Edward Wilson',TO_DATE('2000-04-22','YYYY-MM-DD'),'F',7654321090,'76 Maple St, Hamlet','AB-',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Elijah','Brown','William Brown',TO_DATE('2001-05-03','YYYY-MM-DD'),'M',6543210989,'11 Oak Ave, Citycenter','O+',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Sophia','Martin','Robert Martin',TO_DATE('1999-06-11','YYYY-MM-DD'),'F',5432109878,'42 Birch Blvd, Townsville','A-',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Liam','Lewis','James Lewis',TO_DATE('2002-09-12','YYYY-MM-DD'),'M',4321098767,'31 Cedar Rd, Cityland','B+',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Chloe','Hernandez','Anthony Hernandez',TO_DATE('2000-03-22','YYYY-MM-DD'),'F',3210987656,'65 Elm Ave, Hamlet','AB-',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Oliver','Smith','Robert Smith',TO_DATE('2000-01-10','YYYY-MM-DD'),'M',9876543210,'34 Maple St, Citypoint','O+',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Emma','Johnson','Charles Johnson',TO_DATE('1999-09-20','YYYY-MM-DD'),'F',8765432109,'45 Elm Rd, Townsville','A-',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Jacob','Williams','James Williams',TO_DATE('2001-03-15','YYYY-MM-DD'),'M',7654321098,'67 Birch Blvd, Cityland','B+',2022,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Ava','Brown','Joshua Brown',TO_DATE('2002-06-22','YYYY-MM-DD'),'F',6543210987,'12 Cedar St, Hamlet','AB-',2020,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Mason','Garcia','Edward Garcia',TO_DATE('2000-11-05','YYYY-MM-DD'),'M',5432109876,'76 Pine Blvd, Citycenter','O-',2021,'B33MrLaWhG702','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Isabella','Martinez','Anthony Martinez',TO_DATE('2001-12-17','YYYY-MM-DD'),'F',4321098765,'78 Fir Ln, Cityville','A+',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'William','Rodriguez','David Rodriguez',TO_DATE('2002-05-30','YYYY-MM-DD'),'M',3210987654,'23 Maple Rd, Cityland','B-',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Mia','Wilson','Michael Wilson',TO_DATE('1999-08-12','YYYY-MM-DD'),'F',2109876543,'87 Cedar Ave, Townsville','AB+',2021,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Elijah','Thomas','Charles Thomas',TO_DATE('2000-07-25','YYYY-MM-DD'),'M',1098765432,'72 Birch Blvd, Hamlet','O+',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Grace','Taylor','Thomas Taylor',TO_DATE('2001-04-09','YYYY-MM-DD'),'F',9878909876,'56 Fir Rd, Citypoint','A-',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Benjamin','Lee','Joshua Lee',TO_DATE('2002-10-14','YYYY-MM-DD'),'M',8765432101,'21 Cedar Blvd, Cityland','B+',2021,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Chloe','Martinez','Edward Martinez',TO_DATE('1999-11-30','YYYY-MM-DD'),'F',7654321090,'76 Maple St, Hamlet','AB-',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Jackson','Davis','William Davis',TO_DATE('2000-02-22','YYYY-MM-DD'),'M',6543210989,'11 Oak Ave, Citycenter','O+',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Ava','Hernandez','Robert Hernandez',TO_DATE('2001-09-05','YYYY-MM-DD'),'F',5432109878,'42 Birch Blvd, Townsville','A-',2021,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Lucas','Lee','James Lee',TO_DATE('2002-01-17','YYYY-MM-DD'),'M',4321098767,'31 Cedar Rd, Cityland','B+',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Sophia','Wilson','Anthony Wilson',TO_DATE('2000-03-18','YYYY-MM-DD'),'F',3210987656,'65 Elm Ave, Hamlet','AB-',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'James','Martinez','Robert Martinez',TO_DATE('2000-04-11','YYYY-MM-DD'),'M',9876543210,'34 Maple St, Citypoint','O+',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Charlotte','Thompson','Charles Thompson',TO_DATE('1999-09-25','YYYY-MM-DD'),'F',8765432109,'45 Elm Rd, Townsville','A-',2021,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Daniel','Brown','James Brown',TO_DATE('2001-08-14','YYYY-MM-DD'),'M',7654321098,'67 Birch Blvd, Cityland','B+',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Sophia','Johnson','Joshua Johnson',TO_DATE('2002-03-11','YYYY-MM-DD'),'F',6543210987,'12 Cedar St, Hamlet','AB-',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Elijah','Lee','Edward Lee',TO_DATE('2000-05-15','YYYY-MM-DD'),'M',5432109876,'76 Pine Blvd, Citycenter','O-',2021,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Isabella','Smith','Anthony Smith',TO_DATE('2001-06-27','YYYY-MM-DD'),'F',4321098765,'78 Fir Ln, Cityville','A+',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Lucas','Davis','David Davis',TO_DATE('2002-10-30','YYYY-MM-DD'),'M',3210987654,'23 Maple Rd, Cityland','B-',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Mia','Garcia','Michael Garcia',TO_DATE('1999-12-19','YYYY-MM-DD'),'F',2109876543,'87 Cedar Ave, Townsville','AB+',2021,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Samuel','Martinez','Charles Martinez',TO_DATE('2000-02-09','YYYY-MM-DD'),'M',1098765432,'72 Birch Blvd, Hamlet','O+',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Emma','Taylor','Thomas Taylor',TO_DATE('2001-01-24','YYYY-MM-DD'),'F',9878909876,'56 Fir Rd, Citypoint','A-',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Jackson','Wilson','Joshua Wilson',TO_DATE('2002-07-02','YYYY-MM-DD'),'M',8765432101,'21 Cedar Blvd, Cityland','B+',2021,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Ava','Johnson','Edward Johnson',TO_DATE('2000-11-18','YYYY-MM-DD'),'F',7654321090,'76 Maple St, Hamlet','AB-',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Elijah','White','William White',TO_DATE('2001-08-15','YYYY-MM-DD'),'M',6543210989,'11 Oak Ave, Citycenter','O+',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Sophia','Harris','Robert Harris',TO_DATE('1999-03-29','YYYY-MM-DD'),'F',5432109878,'42 Birch Blvd, Townsville','A-',2021,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Liam','Clark','James Clark',TO_DATE('2002-10-06','YYYY-MM-DD'),'M',4321098767,'31 Cedar Rd, Cityland','B+',2022,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT 'Chloe','Martinez','Anthony Martinez',TO_DATE('2000-09-02','YYYY-MM-DD'),'F',3210987656,'65 Elm Ave, Hamlet','AB-',2020,'B30MsZaCoI902','Pine Valley Hostel140W07' FROM dual;
SELECT * FROM University_Students
TRUNCATE TABLE University_Students

INSERT INTO University_Hostel_Allotment (Room_Number, Room_Type, Allotment_Date, Student_ID, Hostel_ID)
SELECT '100','Single', TO_DATE('2023-01-01','YYYY-MM-DD'),'21B30PrBrSmA102AbTh120902F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '101','Double', TO_DATE('2023-01-02','YYYY-MM-DD'),'21B30PrBrSmA102BeGa050102M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '102','Triple', TO_DATE('2023-01-03','YYYY-MM-DD'),'21B30PrBrSmA102OlRo140801F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '103','Single', TO_DATE('2023-01-04','YYYY-MM-DD'),'21B30PrBrSmA102LuLe030400M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '104','Double', TO_DATE('2023-01-05','YYYY-MM-DD'),'21B30PrBrSmA102IsWa291001F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '105','Triple', TO_DATE('2023-01-06','YYYY-MM-DD'),'21B30PrBrSmA102DaHa220200M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '106','Single', TO_DATE('2023-01-07','YYYY-MM-DD'),'21B30PrBrSmA102HaAl110602F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '107','Double', TO_DATE('2023-01-08','YYYY-MM-DD'),'21B30PrBrSmA102ElYo041101M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '108','Triple', TO_DATE('2023-01-09','YYYY-MM-DD'),'21C28PrCaWiA103AvKi170202F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '109','Single', TO_DATE('2023-01-10','YYYY-MM-DD'),'21C28PrCaWiA103JaSc260301M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '110','Double', TO_DATE('2023-01-11','YYYY-MM-DD'),'21C28PrCaWiA103GrCa151000F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '111','Triple', TO_DATE('2023-01-12','YYYY-MM-DD'),'21C28PrCaWiA103NoCo010702M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '112','Single', TO_DATE('2023-01-13','YYYY-MM-DD'),'21C28PrCaWiA103ElRe090901F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '113','Single', TO_DATE('2023-01-14','YYYY-MM-DD'),'21C28PrCaWiA103WiPa280802M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '114','Double', TO_DATE('2023-01-15','YYYY-MM-DD'),'21C28PrCaWiA103SaMi200302M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '115','Triple', TO_DATE('2023-01-16','YYYY-MM-DD'),'21C28PrCaWiA103LiMa150601F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '116','Single', TO_DATE('2023-01-17','YYYY-MM-DD'),'21C28PrCaWiA103EtBr011200M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '117','Double', TO_DATE('2023-01-18','YYYY-MM-DD'),'21C28PrCaWiA103SoAn050502F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '118','Triple', TO_DATE('2023-01-19','YYYY-MM-DD'),'21C28PrCaWiA103JaTh140901M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '119','Single', TO_DATE('2023-01-20','YYYY-MM-DD'),'21C28PrCaWiA103MiTa290702F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '120','Double', TO_DATE('2023-01-21','YYYY-MM-DD'),'21C28PrCaWiA103AiHa111100M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '121','Triple', TO_DATE('2023-01-22','YYYY-MM-DD'),'21C28PrCaWiA103AvWh200801F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '122','Single', TO_DATE('2023-01-23','YYYY-MM-DD'),'21C28PrCaWiA103WiGa250202M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '123','Double', TO_DATE('2023-01-24','YYYY-MM-DD'),'21C28PrCaWiA103EmRo120101F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '124','Triple', TO_DATE('2023-01-25','YYYY-MM-DD'),'21C28PrCaWiA103DaLe160402M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '125','Single', TO_DATE('2023-01-26','YYYY-MM-DD'),'21C28PrCaWiA103ChWa301001F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '126','Single', TO_DATE('2023-01-27','YYYY-MM-DD'),'21C28PrCaWiA103MiYo090300M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '127','Double', TO_DATE('2023-01-28','YYYY-MM-DD'),'21C28PrCaWiA103HaKi230602F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '128','Triple', TO_DATE('2023-01-29','YYYY-MM-DD'),'21C28PrCaWiA103BeSc121201M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '129','Single', TO_DATE('2023-01-30','YYYY-MM-DD'),'21C28PrCaWiA103ElGr050702F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '130','Double', TO_DATE('2023-01-31','YYYY-MM-DD'),'21C28PrCaWiA103JoHa141101M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '131','Triple', TO_DATE('2023-02-01','YYYY-MM-DD'),'21C28PrCaWiA103SoAl170400F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '132','Single', TO_DATE('2023-02-02','YYYY-MM-DD'),'21C28PrCaWiA103LuKi280102M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '133','Double', TO_DATE('2023-02-03','YYYY-MM-DD'),'21C28PrCaWiA103JaHa190101M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '134','Triple', TO_DATE('2023-02-04','YYYY-MM-DD'),'21A20PrDaBrB201MiWh050300F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '135','Single', TO_DATE('2023-02-05','YYYY-MM-DD'),'21A20PrDaBrB201WiTh210602M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '136','Double', TO_DATE('2023-02-06','YYYY-MM-DD'),'21A20PrDaBrB201SoMa130901F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '137','Triple', TO_DATE('2023-02-07','YYYY-MM-DD'),'21A20PrDaBrB201BeBr291102M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '138','Single', TO_DATE('2023-02-08','YYYY-MM-DD'),'21A20PrDaBrB201IsLe230700F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '139','Single', TO_DATE('2023-02-09','YYYY-MM-DD'),'21A20PrDaBrB201EtWi100401M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '140','Double', TO_DATE('2023-02-10','YYYY-MM-DD'),'21A20PrDaBrB201ElAn180502F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '141','Triple', TO_DATE('2023-02-11','YYYY-MM-DD'),'21A20PrDaBrB201LuMa301001M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '142','Single', TO_DATE('2023-02-12','YYYY-MM-DD'),'21A20PrDaBrB201ChRo150102F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '143','Double', TO_DATE('2023-02-13','YYYY-MM-DD'),'21A20PrDaBrB201JaTa280301M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '144','Triple', TO_DATE('2023-02-14','YYYY-MM-DD'),'21A20PrDaBrB201AbSc051202F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '145','Single', TO_DATE('2023-02-15','YYYY-MM-DD'),'21A20PrDaBrB201AiHa140200M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '146','Double', TO_DATE('2023-02-16','YYYY-MM-DD'),'21A20PrDaBrB201ElYo241101F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '147','Triple', TO_DATE('2023-02-17','YYYY-MM-DD'),'21A20PrDaBrB201GrHa170402M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '148','Single', TO_DATE('2023-02-18','YYYY-MM-DD'),'21A20PrDaBrB201DaKi080601F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '149','Double', TO_DATE('2023-02-19','YYYY-MM-DD'),'21A20PrDaBrB201WiLe100802M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '150','Triple', TO_DATE('2023-02-20','YYYY-MM-DD'),'21A20PrDaBrB201SoGr290500F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '151','Single', TO_DATE('2023-02-21','YYYY-MM-DD'),'21A20PrDaBrB201JaAl180901M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '152','Single', TO_DATE('2023-02-22','YYYY-MM-DD'),'21B22MsEmDaB202MiRo200201F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '153','Double', TO_DATE('2023-02-23','YYYY-MM-DD'),'21B22MsEmDaB202WiJo100300M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '154','Triple', TO_DATE('2023-02-24','YYYY-MM-DD'),'21B22MsEmDaB202EmDa250801F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '155','Single', TO_DATE('2023-02-25','YYYY-MM-DD'),'21B22MsEmDaB202JaBr141002M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '156','Double', TO_DATE('2023-02-26','YYYY-MM-DD'),'21B22MsEmDaB202AbWi180501F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '157','Triple', TO_DATE('2023-02-27','YYYY-MM-DD'),'21B22MsEmDaB202SaTa290100M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '158','Single', TO_DATE('2023-02-28','YYYY-MM-DD'),'21B22MsEmDaB202LuSc051102M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '159','Double', TO_DATE('2023-03-01','YYYY-MM-DD'),'21B22MsEmDaB202ElMa220701F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '160','Triple', TO_DATE('2023-03-02','YYYY-MM-DD'),'21B22MsEmDaB202AiKi300902M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '161','Single', TO_DATE('2023-03-03','YYYY-MM-DD'),'21B22MsEmDaB202ChYo140600F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '162','Double', TO_DATE('2023-03-04','YYYY-MM-DD'),'21B22MsEmDaB202MiAn110401M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '163','Triple', TO_DATE('2023-03-05','YYYY-MM-DD'),'21B22MsEmDaB202GrHa230502F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '164','Single', TO_DATE('2023-03-06','YYYY-MM-DD'),'21B22MsEmDaB202JoWh070301M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '165','Single', TO_DATE('2023-03-07','YYYY-MM-DD'),'21B22MsEmDaB202LiRo011200F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '166','Double', TO_DATE('2023-03-08','YYYY-MM-DD'),'21B22MsEmDaB202EtLe200202M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '167','Triple', TO_DATE('2023-03-09','YYYY-MM-DD'),'21B22MsEmDaB202SoTa141101F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '168','Single', TO_DATE('2023-03-10','YYYY-MM-DD'),'21B22MsEmDaB202WiSc210900M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '169','Double', TO_DATE('2023-03-11','YYYY-MM-DD'),'21B22MsEmDaB202JaGa180601M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '170','Triple', TO_DATE('2023-03-12','YYYY-MM-DD'),'21B22MsEmDaB202AvAl050102F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '171','Single', TO_DATE('2023-03-13','YYYY-MM-DD'),'21B22MsEmDaB202MiCl220301F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '172','Double', TO_DATE('2023-03-14','YYYY-MM-DD'),'20C18PrFiGaB203JaSm150500M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '173','Triple', TO_DATE('2023-03-15','YYYY-MM-DD'),'20C18PrFiGaB203EmJo220801F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '174','Single', TO_DATE('2023-03-16','YYYY-MM-DD'),'21C18PrFiGaB203LiWi011299M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '175','Double', TO_DATE('2023-03-17','YYYY-MM-DD'),'21C18PrFiGaB203SoBr101100F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '176','Triple', TO_DATE('2023-03-18','YYYY-MM-DD'),'22C18PrFiGaB203NoJo050302M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '177','Single', TO_DATE('2023-03-19','YYYY-MM-DD'),'20C18PrFiGaB203MiGa300700F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '178','Single', TO_DATE('2023-03-20','YYYY-MM-DD'),'21C18PrFiGaB203EtMa150901M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '179','Double', TO_DATE('2023-03-21','YYYY-MM-DD'),'22C18PrFiGaB203AvDa280600F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '180','Triple', TO_DATE('2023-03-22','YYYY-MM-DD'),'19C18PrFiGaB203MaRo120498M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '181','Single', TO_DATE('2023-03-23','YYYY-MM-DD'),'23C18PrFiGaB203IsHe231002F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '182','Double', TO_DATE('2023-03-24','YYYY-MM-DD'),'20C18PrFiGaB203LuWi140201M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '183','Triple', TO_DATE('2023-03-25','YYYY-MM-DD'),'19C18PrFiGaB203AmLe200799F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '184','Single', TO_DATE('2023-03-26','YYYY-MM-DD'),'21C18PrFiGaB203AiLe180502M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '185','Double', TO_DATE('2023-03-27','YYYY-MM-DD'),'20C18PrFiGaB203ChWa301200F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '186','Triple', TO_DATE('2023-03-28','YYYY-MM-DD'),'21C18PrFiGaB203JaHa170899M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '187','Single', TO_DATE('2023-03-29','YYYY-MM-DD'),'22C18PrFiGaB203MiYo260301F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '188','Double', TO_DATE('2023-03-30','YYYY-MM-DD'),'20D24DrGeMaB204LoKi301100M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '189','Triple', TO_DATE('2023-03-31','YYYY-MM-DD'),'20D24DrGeMaB204BeWh120400M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '190','Single', TO_DATE('2023-04-01','YYYY-MM-DD'),'19D24DrGeMaB204GrTh150599F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '191','Single', TO_DATE('2023-04-02','YYYY-MM-DD'),'21D24DrGeMaB204SaMa240701M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '192','Double', TO_DATE('2023-04-03','YYYY-MM-DD'),'22D24DrGeMaB204AbAn301200F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '193','Triple', TO_DATE('2023-04-04','YYYY-MM-DD'),'20D24DrGeMaB204HeTa051002M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '194','Single', TO_DATE('2023-04-05','YYYY-MM-DD'),'21D24DrGeMaB204ElTh181101F','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '195','Double', TO_DATE('2023-04-06','YYYY-MM-DD'),'21D24DrGeMaB204WyJa280600M','Moonlight Hostel120W02' FROM dual
UNION ALL SELECT '196','Triple', TO_DATE('2023-04-07','YYYY-MM-DD'),'22D24DrGeMaB204ScHa220900F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '197','Single', TO_DATE('2023-04-08','YYYY-MM-DD'),'21D24DrGeMaB204OwMa150102M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '198','Double', TO_DATE('2023-04-09','YYYY-MM-DD'),'19D24DrGeMaB204ViTh100498F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '199','Triple', TO_DATE('2023-04-10','YYYY-MM-DD'),'20D24DrGeMaB204AlRo280201M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '200','Single', TO_DATE('2023-04-11','YYYY-MM-DD'),'21D24DrGeMaB204SoCl160300F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '201','Double', TO_DATE('2023-04-12','YYYY-MM-DD'),'20D24DrGeMaB204AnRo201101M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '202','Triple', TO_DATE('2023-04-13','YYYY-MM-DD'),'21D24DrGeMaB204LiLe100800F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '203','Single', TO_DATE('2023-04-14','YYYY-MM-DD'),'22D24DrGeMaB204LuLe301200M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '204','Single', TO_DATE('2023-04-15','YYYY-MM-DD'),'20D24DrGeMaB204EmAl170902F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '205','Double', TO_DATE('2023-04-16','YYYY-MM-DD'),'21D24DrGeMaB204JaWa090301M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '206','Triple', TO_DATE('2023-04-17','YYYY-MM-DD'),'20D24DrGeMaB204OlPe100500F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '207','Single', TO_DATE('2023-04-18','YYYY-MM-DD'),'20D24DrGeMaB204SeGr190201M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '208','Double', TO_DATE('2023-04-19','YYYY-MM-DD'),'21D24DrGeMaB204AmHi250699F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '209','Triple', TO_DATE('2023-04-20','YYYY-MM-DD'),'22D24DrGeMaB204LuSc300700M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '210','Single', TO_DATE('2023-04-21','YYYY-MM-DD'),'21A35PrUmRoC301MiAd141000F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '211','Double', TO_DATE('2023-04-22','YYYY-MM-DD'),'22A35PrUmRoC301AlNe010301M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '212','Triple', TO_DATE('2023-04-23','YYYY-MM-DD'),'21A35PrUmRoC301ChCa050400F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '213','Single', TO_DATE('2023-04-24','YYYY-MM-DD'),'20A35PrUmRoC301BeSa231101M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '214','Double', TO_DATE('2023-04-25','YYYY-MM-DD'),'20A35PrUmRoC301SoPe151202F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '215','Triple', TO_DATE('2023-04-26','YYYY-MM-DD'),'21A35PrUmRoC301WiMo200900M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '216','Single', TO_DATE('2023-04-27','YYYY-MM-DD'),'20A35PrUmRoC301HaRo280300F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '217','Single', TO_DATE('2023-04-28','YYYY-MM-DD'),'21A35PrUmRoC301JaRe101001M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '218','Double', TO_DATE('2023-04-29','YYYY-MM-DD'),'20A35PrUmRoC301ElCo190899F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '219','Triple', TO_DATE('2023-04-30','YYYY-MM-DD'),'21A35PrUmRoC301MaBe220700M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '220','Single', TO_DATE('2023-05-01','YYYY-MM-DD'),'22A35PrUmRoC301LiMu180500F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '221','Double', TO_DATE('2023-05-02','YYYY-MM-DD'),'20A35PrUmRoC301DaDi010101M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '222','Triple', TO_DATE('2023-05-03','YYYY-MM-DD'),'21A35PrUmRoC301NaRa120602F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '223','Single', TO_DATE('2023-05-04','YYYY-MM-DD'),'20A35PrUmRoC301OlPe250100M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '224','Double', TO_DATE('2023-05-05','YYYY-MM-DD'),'21A35PrUmRoC301MiTa150399F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '225','Triple', TO_DATE('2023-05-06','YYYY-MM-DD'),'22A35PrUmRoC301ElBr100601M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '226','Single', TO_DATE('2023-05-07','YYYY-MM-DD'),'20A35PrUmRoC301ChJo201000F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '227','Double', TO_DATE('2023-05-08','YYYY-MM-DD'),'21A35PrUmRoC301LuMi121202M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '228','Triple', TO_DATE('2023-05-09','YYYY-MM-DD'),'22A35PrUmRoC301SoDa300501F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '229','Single', TO_DATE('2023-05-10','YYYY-MM-DD'),'20A35PrUmRoC301JaWi280700M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '230','Single', TO_DATE('2023-05-11','YYYY-MM-DD'),'21A35PrUmRoC301LiMo041199F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '231','Double', TO_DATE('2023-05-12','YYYY-MM-DD'),'22A35PrUmRoC301BeTa140301M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '232','Triple', TO_DATE('2023-05-13','YYYY-MM-DD'),'20A35PrUmRoC301AvCl250400F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '233','Single', TO_DATE('2023-05-14','YYYY-MM-DD'),'21A35PrUmRoC301WyRo190200M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '234','Double', TO_DATE('2023-05-15','YYYY-MM-DD'),'20A35PrUmRoC301HaLe150801F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '235','Triple', TO_DATE('2023-05-16','YYYY-MM-DD'),'21A35PrUmRoC301JaHa111298M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '236','Single', TO_DATE('2023-05-17','YYYY-MM-DD'),'22A35PrUmRoC301ScAd180902F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '237','Double', TO_DATE('2023-05-18','YYYY-MM-DD'),'21A35PrUmRoC301DaWi300700M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '238','Triple', TO_DATE('2023-05-19','YYYY-MM-DD'),'22A35PrUmRoC301EvYo221100F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '239','Single', TO_DATE('2023-05-20','YYYY-MM-DD'),'20A35PrUmRoC301GaTu090401M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '240','Double', TO_DATE('2023-05-21','YYYY-MM-DD'),'20A35PrUmRoC301AmGa050900F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '241','Triple', TO_DATE('2023-05-22','YYYY-MM-DD'),'21A35PrUmRoC301SaMa200299M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '242','Single', TO_DATE('2023-05-23','YYYY-MM-DD'),'22A35PrUmRoC301ScLo150101F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '243','Single', TO_DATE('2023-05-24','YYYY-MM-DD'),'20B31MrIaThC302NoLe220600M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '244','Double', TO_DATE('2023-05-25','YYYY-MM-DD'),'21B31MrIaThC302ChAl100502F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '245','Triple', TO_DATE('2023-05-26','YYYY-MM-DD'),'20B31MrIaThC302HeWr301101M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '246','Single', TO_DATE('2023-05-27','YYYY-MM-DD'),'22B31MrIaThC302LiSc130300F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '247','Double', TO_DATE('2023-05-28','YYYY-MM-DD'),'21B31MrIaThC302AiYo290400M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '248','Triple', TO_DATE('2023-05-29','YYYY-MM-DD'),'20B31MrIaThC302MaHa141299F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '249','Single', TO_DATE('2023-05-30','YYYY-MM-DD'),'21B31MrIaThC302EtTh011002M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '250','Double', TO_DATE('2023-05-31','YYYY-MM-DD'),'20B31MrIaThC302GrGr250100M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '251','Triple', TO_DATE('2023-06-01','YYYY-MM-DD'),'22B31MrIaThC302ViMo070701F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '252','Single', TO_DATE('2023-06-02','YYYY-MM-DD'),'20B31MrIaThC302JaHa161100M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '253','Double', TO_DATE('2023-06-03','YYYY-MM-DD'),'21B31MrIaThC302SoTa300601F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '254','Triple', TO_DATE('2023-06-04','YYYY-MM-DD'),'20B31MrIaThC302SeCl100302M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '255','Single', TO_DATE('2023-06-05','YYYY-MM-DD'),'22B31MrIaThC302AvRo220899F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '256','Single', TO_DATE('2023-06-06','YYYY-MM-DD'),'20B31MrIaThC302LoLe100501M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '257','Double', TO_DATE('2023-06-07','YYYY-MM-DD'),'21B31MrIaThC302EmMa150199F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '258','Triple', TO_DATE('2023-06-08','YYYY-MM-DD'),'22B31MrIaThC302MaPe300600M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '259','Single', TO_DATE('2023-06-09','YYYY-MM-DD'),'20B31MrIaThC302ScJo200900F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '260','Double', TO_DATE('2023-06-10','YYYY-MM-DD'),'21B31MrIaThC302LiSm050402M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '261','Triple', TO_DATE('2023-06-11','YYYY-MM-DD'),'20B31MrIaThC302ChTa250799F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '262','Single', TO_DATE('2023-06-12','YYYY-MM-DD'),'22B31MrIaThC302JaWa151201M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '263','Double', TO_DATE('2023-06-13','YYYY-MM-DD'),'21B31MrIaThC302OlHe101000F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '264','Triple', TO_DATE('2023-06-14','YYYY-MM-DD'),'20B31MrIaThC302DaYo080301M','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '265','Single', TO_DATE('2023-06-15','YYYY-MM-DD'),'21B31MrIaThC302AvKi180499F','Greenfield Hostel200W03' FROM dual
UNION ALL SELECT '266','Double', TO_DATE('2023-06-16','YYYY-MM-DD'),'22B31MrIaThC302HaLo140200F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '267','Triple', TO_DATE('2023-06-17','YYYY-MM-DD'),'20B31MrIaThC302LuSc150501M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '268','Single', TO_DATE('2023-06-18','YYYY-MM-DD'),'21B31MrIaThC302BeGo301200M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '269','Single', TO_DATE('2023-06-19','YYYY-MM-DD'),'20B31MrIaThC302ElRa181102F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '270','Double', TO_DATE('2023-06-20','YYYY-MM-DD'),'21B31MrIaThC302NaCo200699M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '271','Triple', TO_DATE('2023-06-21','YYYY-MM-DD'),'22B31MrIaThC302MiRe250800F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '272','Single', TO_DATE('2023-06-22','YYYY-MM-DD'),'20C29PrJeClC303IsWr170501F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '273','Double', TO_DATE('2023-06-23','YYYY-MM-DD'),'21C29PrJeClC303MaBr090999M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '274','Triple', TO_DATE('2023-06-24','YYYY-MM-DD'),'22C29PrJeClC303SoRe250400F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '275','Single', TO_DATE('2023-06-25','YYYY-MM-DD'),'20C29PrJeClC303JaCo141000M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '276','Double', TO_DATE('2023-06-26','YYYY-MM-DD'),'21C29PrJeClC303AvCa300101F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '277','Triple', TO_DATE('2023-06-27','YYYY-MM-DD'),'20C29PrJeClC303ElHa050802M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '278','Single', TO_DATE('2023-06-28','YYYY-MM-DD'),'22C29PrJeClC303MiHa121299F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '279','Double', TO_DATE('2023-06-29','YYYY-MM-DD'),'21C29PrJeClC303LuAd180600M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '280','Triple', TO_DATE('2023-06-30','YYYY-MM-DD'),'20C29PrJeClC303HaBe151101F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '281','Single', TO_DATE('2023-07-01','YYYY-MM-DD'),'21C29PrJeClC303JaGa240300M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '282','Single', TO_DATE('2023-07-02','YYYY-MM-DD'),'22C29PrJeClC303ChLo050202F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '283','Double', TO_DATE('2023-07-03','YYYY-MM-DD'),'20C29PrJeClC303HePa290701M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '284','Triple', TO_DATE('2023-07-04','YYYY-MM-DD'),'21C29PrJeClC303EvTu010899F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '285','Single', TO_DATE('2023-07-05','YYYY-MM-DD'),'22C29PrJeClC303NaRi231200M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '286','Double', TO_DATE('2023-07-06','YYYY-MM-DD'),'20C29PrJeClC303ScHa090500F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '287','Triple', TO_DATE('2023-07-07','YYYY-MM-DD'),'21C29PrJeClC303GaSc301001M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '288','Single', TO_DATE('2023-07-08','YYYY-MM-DD'),'20C29PrJeClC303AvJo160201F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '289','Double', TO_DATE('2023-07-09','YYYY-MM-DD'),'21C29PrJeClC303LuLe300699M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '290','Triple', TO_DATE('2023-07-10','YYYY-MM-DD'),'22C29PrJeClC303MiWh120400F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '291','Single', TO_DATE('2023-07-11','YYYY-MM-DD'),'20C29PrJeClC303SaHa250800M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '292','Double', TO_DATE('2023-07-12','YYYY-MM-DD'),'21C29PrJeClC303EmMa051101F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '293','Triple', TO_DATE('2023-07-13','YYYY-MM-DD'),'20C29PrJeClC303NoBr210102M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '294','Single', TO_DATE('2023-07-14','YYYY-MM-DD'),'22C29PrJeClC303JaYo141200M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '295','Single', TO_DATE('2023-07-15','YYYY-MM-DD'),'21C29PrJeClC303GrSc170399F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '296','Double', TO_DATE('2023-07-16','YYYY-MM-DD'),'20C29PrJeClC303EtHa300901M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '297','Triple', TO_DATE('2023-07-17','YYYY-MM-DD'),'21C29PrJeClC303ChPe110500F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '298','Single', TO_DATE('2023-07-18','YYYY-MM-DD'),'22C29PrJeClC303WiAd091001M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '299','Double', TO_DATE('2023-07-19','YYYY-MM-DD'),'20B27DrZaCoD402LiLe181200F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '300','Triple', TO_DATE('2023-07-20','YYYY-MM-DD'),'21B27DrZaCoD402BeWa270602M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '301','Single', TO_DATE('2023-07-21','YYYY-MM-DD'),'22B27DrZaCoD402HaMa140799F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '302','Double', TO_DATE('2023-07-22','YYYY-MM-DD'),'20B27DrZaCoD402LoWi150401M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '303','Triple', TO_DATE('2023-07-23','YYYY-MM-DD'),'21B27DrZaCoD402ScKi270300F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '304','Single', TO_DATE('2023-07-24','YYYY-MM-DD'),'20B27DrZaCoD402ElGr201001M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '305','Double', TO_DATE('2023-07-25','YYYY-MM-DD'),'21B27DrZaCoD402HaWr020999F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '306','Triple', TO_DATE('2023-07-26','YYYY-MM-DD'),'22B27DrZaCoD402AiLe050500M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '307','Single', TO_DATE('2023-07-27','YYYY-MM-DD'),'20B27DrZaCoD402GrHa090402F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '308','Single', TO_DATE('2023-07-28','YYYY-MM-DD'),'21B27DrZaCoD402ChTa111101F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '309','Double', TO_DATE('2023-07-29','YYYY-MM-DD'),'20B27DrZaCoD402LoSc140100M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '310','Triple', TO_DATE('2023-07-30','YYYY-MM-DD'),'22B27DrZaCoD402OlJo030702M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '311','Single', TO_DATE('2023-07-31','YYYY-MM-DD'),'20B27DrZaCoD402SoAd240699F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '312','Double', TO_DATE('2023-08-01','YYYY-MM-DD'),'21B27DrZaCoD402AvTu160900F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '313','Triple', TO_DATE('2023-08-02','YYYY-MM-DD'),'20B27DrZaCoD402HeWi081202M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '314','Single', TO_DATE('2023-08-03','YYYY-MM-DD'),'21B27DrZaCoD402MiKi270301F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '315','Double', TO_DATE('2023-08-04','YYYY-MM-DD'),'22B27DrZaCoD402JaMa120800M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '316','Triple', TO_DATE('2023-08-05','YYYY-MM-DD'),'20B27DrZaCoD402AmHa140200F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '317','Single', TO_DATE('2023-08-06','YYYY-MM-DD'),'21B27DrZaCoD402ElSc210501M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '318','Double', TO_DATE('2023-08-07','YYYY-MM-DD'),'22B27DrZaCoD402LuCa300102M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '319','Triple', TO_DATE('2023-08-08','YYYY-MM-DD'),'20B27DrZaCoD402HaWr020300F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '320','Single', TO_DATE('2023-08-09','YYYY-MM-DD'),'20B27DrZaCoD402NoAd151000M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '321','Single', TO_DATE('2023-08-10','YYYY-MM-DD'),'21B27DrZaCoD402IsHa300501F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '322','Double', TO_DATE('2023-08-11','YYYY-MM-DD'),'22B27DrZaCoD402ElCl220999M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '323','Triple', TO_DATE('2023-08-12','YYYY-MM-DD'),'20B27DrZaCoD402MiBr180700F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '324','Single', TO_DATE('2023-08-13','YYYY-MM-DD'),'21C23DrOsMaD403WiHa121102M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '325','Double', TO_DATE('2023-08-14','YYYY-MM-DD'),'22C23DrOsMaD403EmKi250601F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '326','Triple', TO_DATE('2023-08-15','YYYY-MM-DD'),'20C23DrOsMaD403JaLe090399M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '327','Single', TO_DATE('2023-08-16','YYYY-MM-DD'),'21C23DrOsMaD403GrSc011201F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '328','Double', TO_DATE('2023-08-17','YYYY-MM-DD'),'22C23DrOsMaD403SaTu190800M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '329','Triple', TO_DATE('2023-08-18','YYYY-MM-DD'),'20C23DrOsMaD403HaWr110102F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '330','Single', TO_DATE('2023-08-19','YYYY-MM-DD'),'21C23DrOsMaD403BeMi150400M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '331','Double', TO_DATE('2023-08-20','YYYY-MM-DD'),'22C23DrOsMaD403ScRo280299F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '332','Triple', TO_DATE('2023-08-21','YYYY-MM-DD'),'20C23DrOsMaD403LuRo050701M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '333','Single', TO_DATE('2023-08-22','YYYY-MM-DD'),'21C23DrOsMaD403ChMa140500F','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '334','Single', TO_DATE('2023-08-23','YYYY-MM-DD'),'22C23DrOsMaD403DaLe180901M','Blue Sky Hostel100W04' FROM dual
UNION ALL SELECT '335','Double', TO_DATE('2023-08-24','YYYY-MM-DD'),'20C23DrOsMaD403LiGo101199F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '336','Triple', TO_DATE('2023-08-25','YYYY-MM-DD'),'20C23DrOsMaD403JaEv051200M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '337','Single', TO_DATE('2023-08-26','YYYY-MM-DD'),'21C23DrOsMaD403ElLe170601F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '338','Double', TO_DATE('2023-08-27','YYYY-MM-DD'),'22C23DrOsMaD403MiJo230799M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '339','Triple', TO_DATE('2023-08-28','YYYY-MM-DD'),'20C23DrOsMaD403AmWi040900F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '340','Single', TO_DATE('2023-08-29','YYYY-MM-DD'),'21C23DrOsMaD403EtHa260502M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '341','Double', TO_DATE('2023-08-30','YYYY-MM-DD'),'22C23DrOsMaD403HaTa290301F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '342','Triple', TO_DATE('2023-08-31','YYYY-MM-DD'),'20C23DrOsMaD403OlMi151099M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '343','Single', TO_DATE('2023-09-01','YYYY-MM-DD'),'21C23DrOsMaD403ChLo120200F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '344','Double', TO_DATE('2023-09-02','YYYY-MM-DD'),'22C23DrOsMaD403BeMa181101M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '345','Triple', TO_DATE('2023-09-03','YYYY-MM-DD'),'20A36DrUmRoE501GrWa010102F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '346','Single', TO_DATE('2023-09-04','YYYY-MM-DD'),'21A36DrUmRoE501SaBr170899M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '347','Single', TO_DATE('2023-09-05','YYYY-MM-DD'),'22A36DrUmRoE501EmGa300401F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '348','Double', TO_DATE('2023-09-06','YYYY-MM-DD'),'20A36DrUmRoE501DaTh260302M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '349','Triple', TO_DATE('2023-09-07','YYYY-MM-DD'),'21A36DrUmRoE501LiRo021200F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '350','Single', TO_DATE('2023-09-08','YYYY-MM-DD'),'22A36DrUmRoE501ElSm140600M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '351','Double', TO_DATE('2023-09-09','YYYY-MM-DD'),'20A36DrUmRoE501HaYo190999F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '352','Triple', TO_DATE('2023-09-10','YYYY-MM-DD'),'20A36DrUmRoE501OlKi150500F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '353','Single', TO_DATE('2023-09-11','YYYY-MM-DD'),'21A36DrUmRoE501ElNe111199M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '354','Double', TO_DATE('2023-09-12','YYYY-MM-DD'),'22A36DrUmRoE501GrCa300301F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '355','Triple', TO_DATE('2023-09-13','YYYY-MM-DD'),'20A36DrUmRoE501NoBr180702M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '356','Single', TO_DATE('2023-09-14','YYYY-MM-DD'),'21A36DrUmRoE501MiHi090900F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '357','Double', TO_DATE('2023-09-15','YYYY-MM-DD'),'22A36DrUmRoE501LuMi231201M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '358','Triple', TO_DATE('2023-09-16','YYYY-MM-DD'),'20A36DrUmRoE501ChWo280899F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '359','Single', TO_DATE('2023-09-17','YYYY-MM-DD'),'21A36DrUmRoE501JaLe050100M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '360','Single', TO_DATE('2023-09-18','YYYY-MM-DD'),'22A36DrUmRoE501LiRi190402F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '361','Double', TO_DATE('2023-09-19','YYYY-MM-DD'),'20A36DrUmRoE501DaPa101000M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '362','Triple', TO_DATE('2023-09-20','YYYY-MM-DD'),'21A36DrUmRoE501ScTu300701F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '363','Single', TO_DATE('2023-09-21','YYYY-MM-DD'),'22A36DrUmRoE501BeDa120299M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '364','Double', TO_DATE('2023-09-22','YYYY-MM-DD'),'20A36DrUmRoE501AmJo151200F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '365','Triple', TO_DATE('2023-09-23','YYYY-MM-DD'),'21A36DrUmRoE501ElMa180102M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '366','Single', TO_DATE('2023-09-24','YYYY-MM-DD'),'22A36DrUmRoE501AvRo220900F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '367','Double', TO_DATE('2023-09-25','YYYY-MM-DD'),'20A36DrUmRoE501SaGr251199M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '368','Triple', TO_DATE('2023-09-26','YYYY-MM-DD'),'20A36DrUmRoE501AlCa010500M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '369','Single', TO_DATE('2023-09-27','YYYY-MM-DD'),'21A36DrUmRoE501SoDa120999F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '370','Double', TO_DATE('2023-09-28','YYYY-MM-DD'),'22A36DrUmRoE501NoMi190401M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '371','Triple', TO_DATE('2023-09-29','YYYY-MM-DD'),'20A36DrUmRoE501IsAn240102F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '372','Single', TO_DATE('2023-09-30','YYYY-MM-DD'),'21A36DrUmRoE501EtJo111200M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '373','Single', TO_DATE('2023-10-01','YYYY-MM-DD'),'22A36DrUmRoE501MiRo280801F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '374','Double', TO_DATE('2023-10-02','YYYY-MM-DD'),'20A36DrUmRoE501LiWi150302M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '375','Triple', TO_DATE('2023-10-03','YYYY-MM-DD'),'21A36DrUmRoE501AmLe301100F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '376','Single', TO_DATE('2023-10-04','YYYY-MM-DD'),'22A36DrUmRoE501LuTh050701M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '377','Double', TO_DATE('2023-10-05','YYYY-MM-DD'),'20A36DrUmRoE501ChMa201099F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '378','Triple', TO_DATE('2023-10-06','YYYY-MM-DD'),'21A36DrUmRoE501BeWh290600M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '379','Single', TO_DATE('2023-10-07','YYYY-MM-DD'),'22C20DrOsMaE503GrJa120501F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '380','Double', TO_DATE('2023-10-08','YYYY-MM-DD'),'20C20DrOsMaE503SaHa040202M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '381','Triple', TO_DATE('2023-10-09','YYYY-MM-DD'),'21C20DrOsMaE503LiMa160800F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '382','Single', TO_DATE('2023-10-10','YYYY-MM-DD'),'22C20DrOsMaE503ElTh300901M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '383','Double', TO_DATE('2023-10-11','YYYY-MM-DD'),'20C20DrOsMaE503HaGa180399F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '384','Triple', TO_DATE('2023-10-12','YYYY-MM-DD'),'20C20DrOsMaE503OlKi140300F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '385','Single', TO_DATE('2023-10-13','YYYY-MM-DD'),'21C20DrOsMaE503ElNe110499M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '386','Single', TO_DATE('2023-10-14','YYYY-MM-DD'),'22C20DrOsMaE503GrCa300701F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '387','Double', TO_DATE('2023-10-15','YYYY-MM-DD'),'20C20DrOsMaE503NoBr050502M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '388','Triple', TO_DATE('2023-10-16','YYYY-MM-DD'),'21C20DrOsMaE503MiHi091000F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '389','Single', TO_DATE('2023-10-17','YYYY-MM-DD'),'22C20DrOsMaE503LuMi211201M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '390','Double', TO_DATE('2023-10-18','YYYY-MM-DD'),'20C20DrOsMaE503ChWo120899F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '391','Triple', TO_DATE('2023-10-19','YYYY-MM-DD'),'21C20DrOsMaE503JaLe030200M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '392','Single', TO_DATE('2023-10-20','YYYY-MM-DD'),'22C20DrOsMaE503LiRi190102F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '393','Double', TO_DATE('2023-10-21','YYYY-MM-DD'),'20C20DrOsMaE503DaPa141000M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '394','Triple', TO_DATE('2023-10-22','YYYY-MM-DD'),'21C20DrOsMaE503ScTu010901F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '395','Single', TO_DATE('2023-10-23','YYYY-MM-DD'),'22C20DrOsMaE503BeDa110699M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '396','Double', TO_DATE('2023-10-24','YYYY-MM-DD'),'20C20DrOsMaE503AmJo241100F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '397','Triple', TO_DATE('2023-10-25','YYYY-MM-DD'),'21A32PrKaMoF601ElMa200202M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '398','Single', TO_DATE('2023-10-26','YYYY-MM-DD'),'22A32PrKaMoF601AvRo220300F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '399','Single', TO_DATE('2023-10-27','YYYY-MM-DD'),'20A32PrKaMoF601SaGr091199M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '400','Double', TO_DATE('2023-10-28','YYYY-MM-DD'),'20A32PrKaMoF601GrWh150600F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '401','Triple', TO_DATE('2023-10-29','YYYY-MM-DD'),'21A32PrKaMoF601WiLe140999M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '402','Single', TO_DATE('2023-10-30','YYYY-MM-DD'),'22A32PrKaMoF601LiCa200301F','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '403','Double', TO_DATE('2023-10-31','YYYY-MM-DD'),'20A32PrKaMoF601JaHa301102M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '404','Triple', TO_DATE('2023-11-01','YYYY-MM-DD'),'21A32PrKaMoF601NoMa091000M','Oak Tree Hostel180W05' FROM dual
UNION ALL SELECT '405','Single', TO_DATE('2023-11-02','YYYY-MM-DD'),'22A32PrKaMoF601EmYo180101F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '406','Double', TO_DATE('2023-11-03','YYYY-MM-DD'),'20A32PrKaMoF601EtRo250799M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '407','Triple', TO_DATE('2023-11-04','YYYY-MM-DD'),'21A32PrKaMoF601SoDa121200F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '408','Single', TO_DATE('2023-11-05','YYYY-MM-DD'),'22A32PrKaMoF601ElNe170402M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '409','Double', TO_DATE('2023-11-06','YYYY-MM-DD'),'20A32PrKaMoF601BeLe210599M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '410','Triple', TO_DATE('2023-11-07','YYYY-MM-DD'),'21A32PrKaMoF601MiMo060900F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '411','Single', TO_DATE('2023-11-08','YYYY-MM-DD'),'22A32PrKaMoF601SaSc040601M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '412','Single', TO_DATE('2023-11-09','YYYY-MM-DD'),'20A32PrKaMoF601AvHi150202F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '413','Double', TO_DATE('2023-11-10','YYYY-MM-DD'),'21A32PrKaMoF601DaTh241000M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '414','Triple', TO_DATE('2023-11-11','YYYY-MM-DD'),'22A32PrKaMoF601ChMa300301F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '415','Single', TO_DATE('2023-11-12','YYYY-MM-DD'),'20A32PrKaMoF601LuGo110899M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '416','Double', TO_DATE('2023-11-13','YYYY-MM-DD'),'20A32PrKaMoF601LiHa020500M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '417','Triple', TO_DATE('2023-11-14','YYYY-MM-DD'),'21A32PrKaMoF601EmJo150399F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '418','Single', TO_DATE('2023-11-15','YYYY-MM-DD'),'22A32PrKaMoF601NoWi221101M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '419','Double', TO_DATE('2023-11-16','YYYY-MM-DD'),'20A32PrKaMoF601AvBr140202F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '420','Triple', TO_DATE('2023-11-17','YYYY-MM-DD'),'21A32PrKaMoF601EtGa080900M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '421','Single', TO_DATE('2023-11-18','YYYY-MM-DD'),'22A32PrKaMoF601IsMa300601F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '422','Double', TO_DATE('2023-11-19','YYYY-MM-DD'),'20A32PrKaMoF601LuLe050402M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '423','Triple', TO_DATE('2023-11-20','YYYY-MM-DD'),'21A32PrKaMoF601SoTh181299F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '424','Single', TO_DATE('2023-11-21','YYYY-MM-DD'),'22A32PrKaMoF601BeHa110800M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '425','Single', TO_DATE('2023-11-22','YYYY-MM-DD'),'20A32PrKaMoF601MiCl251001F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '426','Double', TO_DATE('2023-11-23','YYYY-MM-DD'),'21A32PrKaMoF601SaRo140302M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '427','Triple', TO_DATE('2023-11-24','YYYY-MM-DD'),'22B19DrXeNeF602ChLe090500F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '428','Single', TO_DATE('2023-11-25','YYYY-MM-DD'),'20B19DrXeNeF602JaYo160701M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '429','Double', TO_DATE('2023-11-26','YYYY-MM-DD'),'21B19DrXeNeF602GrHe010199F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '430','Triple', TO_DATE('2023-11-27','YYYY-MM-DD'),'22B19DrXeNeF602ElKi051202M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '431','Single', TO_DATE('2023-11-28','YYYY-MM-DD'),'20B19DrXeNeF602HaAl131100F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '432','Double', TO_DATE('2023-11-29','YYYY-MM-DD'),'20B19DrXeNeF602WiWr070300M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '433','Triple', TO_DATE('2023-11-30','YYYY-MM-DD'),'21B19DrXeNeF602AmSc140599F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '434','Single', TO_DATE('2023-12-01','YYYY-MM-DD'),'22B19DrXeNeF602DaHi230901M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '435','Double', TO_DATE('2023-12-02','YYYY-MM-DD'),'20B19DrXeNeF602SoTo120102F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '436','Triple', TO_DATE('2023-12-03','YYYY-MM-DD'),'21B19DrXeNeF602ElLe041200M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '437','Single', TO_DATE('2023-12-04','YYYY-MM-DD'),'22B19DrXeNeF602IsRi210601F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '438','Single', TO_DATE('2023-12-05','YYYY-MM-DD'),'20B19DrXeNeF602LuDa291002M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '439','Double', TO_DATE('2023-12-06','YYYY-MM-DD'),'21B19DrXeNeF602MiMa260299F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '440','Triple', TO_DATE('2023-12-07','YYYY-MM-DD'),'22B19DrXeNeF602JaGa150800M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '441','Single', TO_DATE('2023-12-08','YYYY-MM-DD'),'20B19DrXeNeF602GrLo301101F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '442','Double', TO_DATE('2023-12-09','YYYY-MM-DD'),'21B19DrXeNeF602BeJo100402M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '443','Triple', TO_DATE('2023-12-10','YYYY-MM-DD'),'22B19DrXeNeF602ChLe190799F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '444','Single', TO_DATE('2023-12-11','YYYY-MM-DD'),'20C21PrWaCrF603SaMa280900M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '445','Double', TO_DATE('2023-12-12','YYYY-MM-DD'),'21C21PrWaCrF603AvAn250501F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '446','Triple', TO_DATE('2023-12-13','YYYY-MM-DD'),'22C21PrWaCrF603NoTh180202M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '447','Single', TO_DATE('2023-12-14','YYYY-MM-DD'),'20C21PrWaCrF603LiRo070100F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '448','Double', TO_DATE('2023-12-15','YYYY-MM-DD'),'20C21PrWaCrF603MiPa010400F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '449','Triple', TO_DATE('2023-12-16','YYYY-MM-DD'),'21C21PrWaCrF603AlEv120699M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '450','Single', TO_DATE('2023-12-17','YYYY-MM-DD'),'22C21PrWaCrF603BeWa190801M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '451','Single', TO_DATE('2023-12-18','YYYY-MM-DD'),'20C21PrWaCrF603GrGo301202F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '452','Double', TO_DATE('2023-12-19','YYYY-MM-DD'),'21C21PrWaCrF603NoHa171100M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '453','Triple', TO_DATE('2023-12-20','YYYY-MM-DD'),'22C21PrWaCrF603OlLe220901F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '454','Single', TO_DATE('2023-12-21','YYYY-MM-DD'),'20C21PrWaCrF603LuMa030202M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '455','Double', TO_DATE('2023-12-22','YYYY-MM-DD'),'21C21PrWaCrF603IsRo101099F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '456','Triple', TO_DATE('2023-12-23','YYYY-MM-DD'),'22C21PrWaCrF603SaDa260700M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '457','Single', TO_DATE('2023-12-24','YYYY-MM-DD'),'20C21PrWaCrF603EmTh140501F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '458','Double', TO_DATE('2023-12-25','YYYY-MM-DD'),'21C21PrWaCrF603JaJo120302M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '459','Triple', TO_DATE('2023-12-26','YYYY-MM-DD'),'22C21PrWaCrF603AvWi010100F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '460','Single', TO_DATE('2023-12-27','YYYY-MM-DD'),'20C21PrWaCrF603ElBr090401M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '461','Double', TO_DATE('2023-12-28','YYYY-MM-DD'),'21C21PrWaCrF603SoMa050899F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '462','Triple', TO_DATE('2023-12-29','YYYY-MM-DD'),'22C21PrWaCrF603LiLe111102M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '463','Single', TO_DATE('2023-12-30','YYYY-MM-DD'),'20A26PrHaWiG701ChHe201200F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '464','Single', TO_DATE('2023-12-31','YYYY-MM-DD'),'20A26PrHaWiG701WiWr010500M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '465','Double', TO_DATE('2024-01-01','YYYY-MM-DD'),'21A26PrHaWiG701OlSc100499F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '466','Triple', TO_DATE('2024-01-02','YYYY-MM-DD'),'22A26PrHaWiG701DaHi211101M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '467','Single', TO_DATE('2024-01-03','YYYY-MM-DD'),'20A26PrHaWiG701SoTo180302F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '468','Double', TO_DATE('2024-01-04','YYYY-MM-DD'),'21A26PrHaWiG701ElLe090700M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '469','Triple', TO_DATE('2024-01-05','YYYY-MM-DD'),'22A26PrHaWiG701IsRi300801F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '470','Single', TO_DATE('2024-01-06','YYYY-MM-DD'),'20A26PrHaWiG701LuDa220602M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '471','Double', TO_DATE('2024-01-07','YYYY-MM-DD'),'21A26PrHaWiG701MiMa141099F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '472','Triple', TO_DATE('2024-01-08','YYYY-MM-DD'),'22A26PrHaWiG701JaGa061200M','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '473','Single', TO_DATE('2024-01-09','YYYY-MM-DD'),'20A26PrHaWiG701GrLo010901F','Maple Leaf Hostel160W06' FROM dual
UNION ALL SELECT '474','Double', TO_DATE('2024-01-10','YYYY-MM-DD'),'21A26PrHaWiG701BeJo170202M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '475','Triple', TO_DATE('2024-01-11','YYYY-MM-DD'),'22A26PrHaWiG701ChLe210199F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '476','Single', TO_DATE('2024-01-12','YYYY-MM-DD'),'20A26PrHaWiG701SaMa291100M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '477','Single', TO_DATE('2024-01-13','YYYY-MM-DD'),'21A26PrHaWiG701AvAn200501F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '478','Double', TO_DATE('2024-01-14','YYYY-MM-DD'),'22A26PrHaWiG701NoTh080402M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '479','Triple', TO_DATE('2024-01-15','YYYY-MM-DD'),'20A26PrHaWiG701LiRo150300F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '480','Single', TO_DATE('2024-01-16','YYYY-MM-DD'),'20A26PrHaWiG701MiTu110400F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '481','Double', TO_DATE('2024-01-17','YYYY-MM-DD'),'21A26PrHaWiG701AlEv240699M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '482','Triple', TO_DATE('2024-01-18','YYYY-MM-DD'),'22A26PrHaWiG701BeWa050901M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '483','Single', TO_DATE('2024-01-19','YYYY-MM-DD'),'20A26PrHaWiG701GrGo291202F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '484','Double', TO_DATE('2024-01-20','YYYY-MM-DD'),'21A26PrHaWiG701NoHa141100M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '485','Triple', TO_DATE('2024-01-21','YYYY-MM-DD'),'22A26PrHaWiG701OlLe100701F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '486','Single', TO_DATE('2024-01-22','YYYY-MM-DD'),'20A26PrHaWiG701LuMa240202M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '487','Double', TO_DATE('2024-01-23','YYYY-MM-DD'),'21B33MrLaWhG702IsRo171099F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '488','Triple', TO_DATE('2024-01-24','YYYY-MM-DD'),'22B33MrLaWhG702SaDa310800M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '489','Single', TO_DATE('2024-01-25','YYYY-MM-DD'),'20B33MrLaWhG702EmTh120301F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '490','Single', TO_DATE('2024-01-26','YYYY-MM-DD'),'21B33MrLaWhG702JaJo200502M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '491','Double', TO_DATE('2024-01-27','YYYY-MM-DD'),'22B33MrLaWhG702AvWi020900F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '492','Triple', TO_DATE('2024-01-28','YYYY-MM-DD'),'20B33MrLaWhG702ElBr291001M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '493','Single', TO_DATE('2024-01-29','YYYY-MM-DD'),'21B33MrLaWhG702SoMa060899F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '494','Double', TO_DATE('2024-01-30','YYYY-MM-DD'),'22B33MrLaWhG702LiLe190602M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '495','Triple', TO_DATE('2024-01-31','YYYY-MM-DD'),'20B33MrLaWhG702ChHe121200F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '496','Single', TO_DATE('2024-02-01','YYYY-MM-DD'),'20B33MrLaWhG702JaAn150100M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '497','Double', TO_DATE('2024-02-02','YYYY-MM-DD'),'21B33MrLaWhG702ChMa250999F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '498','Triple', TO_DATE('2024-02-03','YYYY-MM-DD'),'22B33MrLaWhG702DaWi301101M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '499','Single', TO_DATE('2024-02-04','YYYY-MM-DD'),'20B33MrLaWhG702SoTh110302F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '500','Double', TO_DATE('2024-02-05','YYYY-MM-DD'),'21B33MrLaWhG702ElYo050500M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '501','Triple', TO_DATE('2024-02-06','YYYY-MM-DD'),'22B33MrLaWhG702IsLe171001F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '502','Single', TO_DATE('2024-02-07','YYYY-MM-DD'),'20B33MrLaWhG702LuBr210702M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '503','Single', TO_DATE('2024-02-08','YYYY-MM-DD'),'21B33MrLaWhG702MiRo141299F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '504','Double', TO_DATE('2024-02-09','YYYY-MM-DD'),'22B33MrLaWhG702SaGa280200M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '505','Triple', TO_DATE('2024-02-10','YYYY-MM-DD'),'20B33MrLaWhG702EmMa060801F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '506','Single', TO_DATE('2024-02-11','YYYY-MM-DD'),'21B33MrLaWhG702JaJo211102M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '507','Double', TO_DATE('2024-02-12','YYYY-MM-DD'),'22B33MrLaWhG702AvWi220400F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '508','Triple', TO_DATE('2024-02-13','YYYY-MM-DD'),'20B33MrLaWhG702ElBr030501M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '509','Single', TO_DATE('2024-02-14','YYYY-MM-DD'),'21B33MrLaWhG702SoMa110699F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '510','Double', TO_DATE('2024-02-15','YYYY-MM-DD'),'22B33MrLaWhG702LiLe120902M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '511','Triple', TO_DATE('2024-02-16','YYYY-MM-DD'),'20B33MrLaWhG702ChHe220300F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '512','Single', TO_DATE('2024-02-17','YYYY-MM-DD'),'20B33MrLaWhG702OlSm100100M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '513','Double', TO_DATE('2024-02-18','YYYY-MM-DD'),'21B33MrLaWhG702EmJo200999F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '514','Triple', TO_DATE('2024-02-19','YYYY-MM-DD'),'22B33MrLaWhG702JaWi150301M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '515','Single', TO_DATE('2024-02-20','YYYY-MM-DD'),'20B33MrLaWhG702AvBr220602F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '516','Single', TO_DATE('2024-02-21','YYYY-MM-DD'),'21B33MrLaWhG702MaGa051100M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '517','Double', TO_DATE('2024-02-22','YYYY-MM-DD'),'22B30MsZaCoI902IsMa171201F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '518','Triple', TO_DATE('2024-02-23','YYYY-MM-DD'),'20B30MsZaCoI902WiRo300502M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '519','Single', TO_DATE('2024-02-24','YYYY-MM-DD'),'21B30MsZaCoI902MiWi120899F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '520','Double', TO_DATE('2024-02-25','YYYY-MM-DD'),'22B30MsZaCoI902ElTh250700M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '521','Triple', TO_DATE('2024-02-26','YYYY-MM-DD'),'20B30MsZaCoI902GrTa090401F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '522','Single', TO_DATE('2024-02-27','YYYY-MM-DD'),'21B30MsZaCoI902BeLe141002M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '523','Double', TO_DATE('2024-02-28','YYYY-MM-DD'),'22B30MsZaCoI902ChMa301199F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '524','Triple', TO_DATE('2024-02-29','YYYY-MM-DD'),'20B30MsZaCoI902JaDa220200M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '525','Single', TO_DATE('2024-03-01','YYYY-MM-DD'),'21B30MsZaCoI902AvHe050901F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '526','Double', TO_DATE('2024-03-02','YYYY-MM-DD'),'22B30MsZaCoI902LuLe170102M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '527','Triple', TO_DATE('2024-03-03','YYYY-MM-DD'),'20B30MsZaCoI902SoWi180300F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '528','Single', TO_DATE('2024-03-04','YYYY-MM-DD'),'20B30MsZaCoI902JaMa110400M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '529','Single', TO_DATE('2024-03-05','YYYY-MM-DD'),'21B30MsZaCoI902ChTh250999F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '530','Double', TO_DATE('2024-03-06','YYYY-MM-DD'),'22B30MsZaCoI902DaBr140801M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '531','Triple', TO_DATE('2024-03-07','YYYY-MM-DD'),'20B30MsZaCoI902SoJo110302F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '532','Single', TO_DATE('2024-03-08','YYYY-MM-DD'),'21B30MsZaCoI902ElLe150500M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '533','Double', TO_DATE('2024-03-09','YYYY-MM-DD'),'22B30MsZaCoI902IsSm270601F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '534','Triple', TO_DATE('2024-03-10','YYYY-MM-DD'),'20B30MsZaCoI902LuDa301002M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '535','Single', TO_DATE('2024-03-11','YYYY-MM-DD'),'21B30MsZaCoI902MiGa191299F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '536','Double', TO_DATE('2024-03-12','YYYY-MM-DD'),'22B30MsZaCoI902SaMa090200M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '537','Triple', TO_DATE('2024-03-13','YYYY-MM-DD'),'20B30MsZaCoI902EmTa240101F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '538','Single', TO_DATE('2024-03-14','YYYY-MM-DD'),'21B30MsZaCoI902JaWi020702M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '539','Double', TO_DATE('2024-03-15','YYYY-MM-DD'),'22B30MsZaCoI902AvJo181100F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '540','Triple', TO_DATE('2024-03-16','YYYY-MM-DD'),'20B30MsZaCoI902ElWh150801M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '541','Single', TO_DATE('2024-03-17','YYYY-MM-DD'),'21B30MsZaCoI902SoHa290399F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '542','Single', TO_DATE('2024-03-18','YYYY-MM-DD'),'22B30MsZaCoI902LiCl061002M','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '543','Double', TO_DATE('2024-03-19','YYYY-MM-DD'),'20B30MsZaCoI902ChMa020900F','Pine Valley Hostel140W07' FROM dual
UNION ALL SELECT '544','Triple', TO_DATE('2024-03-20','YYYY-MM-DD'),'20A25PrAlJoA101EmJo150202F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '545','Single', TO_DATE('2024-03-21','YYYY-MM-DD'),'20A25PrAlJoA101DaSm200601M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '546','Double', TO_DATE('2024-03-22','YYYY-MM-DD'),'20A25PrAlJoA101SaWi250302F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '547','Triple', TO_DATE('2024-03-23','YYYY-MM-DD'),'20A25PrAlJoA101JoBr111100M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '548','Single', TO_DATE('2024-03-24','YYYY-MM-DD'),'20A25PrAlJoA101JeDa300702F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '549','Double', TO_DATE('2024-03-25','YYYY-MM-DD'),'20A25PrAlJoA101DaMi140801M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '550','Triple', TO_DATE('2024-03-26','YYYY-MM-DD'),'20A25PrAlJoA101LaWi120402F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '551','Single', TO_DATE('2024-03-27','YYYY-MM-DD'),'20A25PrAlJoA101MiTa080901M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '552','Double', TO_DATE('2024-03-28','YYYY-MM-DD'),'20A25PrAlJoA101OlAn190502F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '553','Triple', TO_DATE('2024-03-29','YYYY-MM-DD'),'20A25PrAlJoA101JoTh221200M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '554','Single', TO_DATE('2024-03-30','YYYY-MM-DD'),'20A25PrAlJoA101SoJa300101F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '555','Single', TO_DATE('2024-03-31','YYYY-MM-DD'),'20A25PrAlJoA101JaWh031002M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '556','Double', TO_DATE('2024-04-01','YYYY-MM-DD'),'20A25PrAlJoA101ChHa151202F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '557','Triple', TO_DATE('2024-04-02','YYYY-MM-DD'),'20A25PrAlJoA101EtMa060401M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '558','Single', TO_DATE('2024-04-03','YYYY-MM-DD'),'20A25PrAlJoA101MiTh280701F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '559','Double', TO_DATE('2024-04-04','YYYY-MM-DD'),'20A25PrAlJoA101BeGa090802M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '560','Triple', TO_DATE('2024-04-05','YYYY-MM-DD'),'20A25PrAlJoA101LiMa160300F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '561','Single', TO_DATE('2024-04-06','YYYY-MM-DD'),'20A25PrAlJoA101JaRo040902M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '562','Double', TO_DATE('2024-04-07','YYYY-MM-DD'),'20A25PrAlJoA101ChCl111101F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '563','Triple', TO_DATE('2024-04-08','YYYY-MM-DD'),'21A25PrAlJoA101EtWi120102M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '564','Single', TO_DATE('2024-04-09','YYYY-MM-DD'),'21A25PrAlJoA101AvJo250501F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '565','Double', TO_DATE('2024-04-10','YYYY-MM-DD'),'21A25PrAlJoA101MiSm070302F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '566','Triple', TO_DATE('2024-04-11','YYYY-MM-DD'),'21A25PrAlJoA101LiBr201100M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '567','Single', TO_DATE('2024-04-12','YYYY-MM-DD'),'21B30PrBrSmA102HaDa150602F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '568','Single', TO_DATE('2024-04-13','YYYY-MM-DD'),'21B30PrBrSmA102NoTa300901M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '569','Double', TO_DATE('2024-04-14','YYYY-MM-DD'),'21B30PrBrSmA102IsMa280202F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '570','Triple', TO_DATE('2024-04-15','YYYY-MM-DD'),'21B30PrBrSmA102LuGa120801M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '571','Single', TO_DATE('2024-04-16','YYYY-MM-DD'),'21B30PrBrSmA102ChHe040502F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '572','Double', TO_DATE('2024-04-17','YYYY-MM-DD'),'21B30PrBrSmA102MaWi141200M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '573','Triple', TO_DATE('2024-04-18','YYYY-MM-DD'),'21B30PrBrSmA102AmAn180301F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '574','Single', TO_DATE('2024-04-19','YYYY-MM-DD'),'21B30PrBrSmA102ElCl210702M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '575','Double', TO_DATE('2024-04-20','YYYY-MM-DD'),'21B30PrBrSmA102ElLe031002F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '576','Triple', TO_DATE('2024-04-21','YYYY-MM-DD'),'21B30PrBrSmA102AlRo090401M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '577','Single', TO_DATE('2024-04-22','YYYY-MM-DD'),'21B30PrBrSmA102ScLe151101F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '578','Double', TO_DATE('2024-04-23','YYYY-MM-DD'),'21B30PrBrSmA102DaYo270802M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '579','Triple', TO_DATE('2024-04-24','YYYY-MM-DD'),'21B30PrBrSmA102GrAl100200F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '580','Single', TO_DATE('2024-04-25','YYYY-MM-DD'),'21B30PrBrSmA102WiKi200902M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '581','Single', TO_DATE('2024-04-26','YYYY-MM-DD'),'21B30PrBrSmA102SoWr010101F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '582','Double', TO_DATE('2024-04-27','YYYY-MM-DD'),'21B30PrBrSmA102JaAd150302M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '583','Triple', TO_DATE('2024-04-28','YYYY-MM-DD'),'21B30PrBrSmA102MiTh101201F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '584','Single', TO_DATE('2024-04-29','YYYY-MM-DD'),'21B30PrBrSmA102JaWh221100M','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '585','Double', TO_DATE('2024-04-30','YYYY-MM-DD'),'21B30PrBrSmA102EmHa300502F','Sunrise Hostel150W01' FROM dual
UNION ALL SELECT '586','Triple', TO_DATE('2024-05-01','YYYY-MM-DD'),'21B30PrBrSmA102WiMa180701M','Sunrise Hostel150W01' FROM dual;
SELECT * FROM University_Hostel_Allotment
TRUNCATE TABLE University_Hostel_Allotment

INSERT INTO University_Borrowed_Books (Issue_Date, Return_Date, Book_ID, Student_ID)
SELECT TO_DATE('2023-01-01','YYYY-MM-DD'),TO_DATE('2023-01-07','YYYY-MM-DD'),'ITATHH.CO09','21B30PrBrSmA102AbTh120902F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-02','YYYY-MM-DD'),TO_DATE('2023-01-08','YYYY-MM-DD'),'ITATHH.CO09','21B30PrBrSmA102BeGa050102M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-03','YYYY-MM-DD'),TO_DATE('2023-01-09','YYYY-MM-DD'),'ITATHH.CO09','21B30PrBrSmA102OlRo140801F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-04','YYYY-MM-DD'),TO_DATE('2023-01-10','YYYY-MM-DD'),'ITATHH.CO09','21B30PrBrSmA102LuLe030400M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-05','YYYY-MM-DD'),TO_DATE('2023-01-11','YYYY-MM-DD'),'ITATHH.CO09','21B30PrBrSmA102IsWa291001F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-06','YYYY-MM-DD'),TO_DATE('2023-01-12','YYYY-MM-DD'),'ITATHH.CO09','21B30PrBrSmA102DaHa220200M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-07','YYYY-MM-DD'),TO_DATE('2023-01-13','YYYY-MM-DD'),'ITATHH.CO09','21B30PrBrSmA102HaAl110602F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-08','YYYY-MM-DD'),TO_DATE('2023-01-14','YYYY-MM-DD'),'ITATHH.CO09','21B30PrBrSmA102ElYo041101M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-09','YYYY-MM-DD'),TO_DATE('2023-01-15','YYYY-MM-DD'),'ITATHH.CO09','21C28PrCaWiA103AvKi170202F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-10','YYYY-MM-DD'),TO_DATE('2023-01-16','YYYY-MM-DD'),'ITATHH.CO09','21C28PrCaWiA103JaSc260301M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-11','YYYY-MM-DD'),TO_DATE('2023-01-17','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103GrCa151000F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-12','YYYY-MM-DD'),TO_DATE('2023-01-18','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103NoCo010702M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-13','YYYY-MM-DD'),TO_DATE('2023-01-19','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103ElRe090901F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-14','YYYY-MM-DD'),TO_DATE('2023-01-20','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103WiPa280802M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-15','YYYY-MM-DD'),TO_DATE('2023-01-21','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103SaMi200302M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-16','YYYY-MM-DD'),TO_DATE('2023-01-22','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103LiMa150601F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-17','YYYY-MM-DD'),TO_DATE('2023-01-23','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103EtBr011200M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-18','YYYY-MM-DD'),TO_DATE('2023-01-24','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103SoAn050502F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-19','YYYY-MM-DD'),TO_DATE('2023-01-25','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103JaTh140901M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-20','YYYY-MM-DD'),TO_DATE('2023-01-26','YYYY-MM-DD'),'AIAMASTRU10','21C28PrCaWiA103MiTa290702F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-21','YYYY-MM-DD'),TO_DATE('2023-01-27','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103AiHa111100M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-22','YYYY-MM-DD'),TO_DATE('2023-01-28','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103AvWh200801F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-23','YYYY-MM-DD'),TO_DATE('2023-01-29','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103WiGa250202M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-24','YYYY-MM-DD'),TO_DATE('2023-01-30','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103EmRo120101F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-25','YYYY-MM-DD'),TO_DATE('2023-01-31','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103DaLe160402M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-26','YYYY-MM-DD'),TO_DATE('2023-02-01','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103ChWa301001F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-27','YYYY-MM-DD'),TO_DATE('2023-02-02','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103MiYo090300M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-28','YYYY-MM-DD'),TO_DATE('2023-02-03','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103HaKi230602F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-29','YYYY-MM-DD'),TO_DATE('2023-02-04','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103BeSc121201M' FROM dual
UNION ALL SELECT TO_DATE('2023-01-30','YYYY-MM-DD'),TO_DATE('2023-02-05','YYYY-MM-DD'),'CCAHOASCROC.MA08','21C28PrCaWiA103ElGr050702F' FROM dual
UNION ALL SELECT TO_DATE('2023-01-31','YYYY-MM-DD'),TO_DATE('2023-02-06','YYYY-MM-DD'),'TPPANHU99','21C28PrCaWiA103JoHa141101M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-01','YYYY-MM-DD'),TO_DATE('2023-02-07','YYYY-MM-DD'),'TPPANHU99','21C28PrCaWiA103SoAl170400F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-02','YYYY-MM-DD'),TO_DATE('2023-02-08','YYYY-MM-DD'),'TPPANHU99','21C28PrCaWiA103LuKi280102M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-03','YYYY-MM-DD'),TO_DATE('2023-02-09','YYYY-MM-DD'),'TPPANHU99','21C28PrCaWiA103JaHa190101M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-04','YYYY-MM-DD'),TO_DATE('2023-02-10','YYYY-MM-DD'),'TPPANHU99','21A20PrDaBrB201MiWh050300F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-05','YYYY-MM-DD'),TO_DATE('2023-02-11','YYYY-MM-DD'),'TPPANHU99','21A20PrDaBrB201WiTh210602M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-06','YYYY-MM-DD'),TO_DATE('2023-02-12','YYYY-MM-DD'),'TPPANHU99','21A20PrDaBrB201SoMa130901F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-07','YYYY-MM-DD'),TO_DATE('2023-02-13','YYYY-MM-DD'),'TPPANHU99','21A20PrDaBrB201BeBr291102M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-08','YYYY-MM-DD'),TO_DATE('2023-02-14','YYYY-MM-DD'),'TPPANHU99','21A20PrDaBrB201IsLe230700F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-09','YYYY-MM-DD'),TO_DATE('2023-02-15','YYYY-MM-DD'),'TPPANHU99','21A20PrDaBrB201EtWi100401M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-10','YYYY-MM-DD'),TO_DATE('2023-02-16','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201ElAn180502F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-11','YYYY-MM-DD'),TO_DATE('2023-02-17','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201LuMa301001M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-12','YYYY-MM-DD'),TO_DATE('2023-02-18','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201ChRo150102F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-13','YYYY-MM-DD'),TO_DATE('2023-02-19','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201JaTa280301M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-14','YYYY-MM-DD'),TO_DATE('2023-02-20','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201AbSc051202F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-15','YYYY-MM-DD'),TO_DATE('2023-02-21','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201AiHa140200M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-16','YYYY-MM-DD'),TO_DATE('2023-02-22','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201ElYo241101F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-17','YYYY-MM-DD'),TO_DATE('2023-02-23','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201GrHa170402M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-18','YYYY-MM-DD'),TO_DATE('2023-02-24','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201DaKi080601F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-19','YYYY-MM-DD'),TO_DATE('2023-02-25','YYYY-MM-DD'),'DPEOROSERGA94','21A20PrDaBrB201WiLe100802M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-20','YYYY-MM-DD'),TO_DATE('2023-02-26','YYYY-MM-DD'),'DSCABSI10','21A20PrDaBrB201SoGr290500F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-21','YYYY-MM-DD'),TO_DATE('2023-02-27','YYYY-MM-DD'),'DSCABSI10','21A20PrDaBrB201JaAl180901M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-22','YYYY-MM-DD'),TO_DATE('2023-02-28','YYYY-MM-DD'),'DSCABSI10','21B22MsEmDaB202MiRo200201F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-23','YYYY-MM-DD'),TO_DATE('2023-03-01','YYYY-MM-DD'),'DSCABSI10','21B22MsEmDaB202WiJo100300M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-24','YYYY-MM-DD'),TO_DATE('2023-03-02','YYYY-MM-DD'),'DSCABSI10','21B22MsEmDaB202EmDa250801F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-25','YYYY-MM-DD'),TO_DATE('2023-03-03','YYYY-MM-DD'),'DSCABSI10','21B22MsEmDaB202JaBr141002M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-26','YYYY-MM-DD'),TO_DATE('2023-03-04','YYYY-MM-DD'),'DSCABSI10','21B22MsEmDaB202AbWi180501F' FROM dual
UNION ALL SELECT TO_DATE('2023-02-27','YYYY-MM-DD'),TO_DATE('2023-03-05','YYYY-MM-DD'),'DSCABSI10','21B22MsEmDaB202SaTa290100M' FROM dual
UNION ALL SELECT TO_DATE('2023-02-28','YYYY-MM-DD'),TO_DATE('2023-03-06','YYYY-MM-DD'),'DSCABSI10','21B22MsEmDaB202LuSc051102M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-01','YYYY-MM-DD'),TO_DATE('2023-03-07','YYYY-MM-DD'),'DSCABSI10','21B22MsEmDaB202ElMa220701F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-02','YYYY-MM-DD'),TO_DATE('2023-03-08','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202AiKi300902M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-03','YYYY-MM-DD'),TO_DATE('2023-03-09','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202ChYo140600F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-04','YYYY-MM-DD'),TO_DATE('2023-03-10','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202MiAn110401M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-05','YYYY-MM-DD'),TO_DATE('2023-03-11','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202GrHa230502F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-06','YYYY-MM-DD'),TO_DATE('2023-03-12','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202JoWh070301M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-07','YYYY-MM-DD'),TO_DATE('2023-03-13','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202LiRo011200F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-08','YYYY-MM-DD'),TO_DATE('2023-03-14','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202EtLe200202M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-09','YYYY-MM-DD'),TO_DATE('2023-03-15','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202SoTa141101F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-10','YYYY-MM-DD'),TO_DATE('2023-03-16','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202WiSc210900M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-11','YYYY-MM-DD'),TO_DATE('2023-03-17','YYYY-MM-DD'),'TAOCPV1DOE.KN97','21B22MsEmDaB202JaGa180601M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-12','YYYY-MM-DD'),TO_DATE('2023-03-18','YYYY-MM-DD'),'TMMEOSEFRP.BR95','21B22MsEmDaB202AvAl050102F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-13','YYYY-MM-DD'),TO_DATE('2023-03-19','YYYY-MM-DD'),'TMMEOSEFRP.BR95','21B22MsEmDaB202MiCl220301F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-14','YYYY-MM-DD'),TO_DATE('2023-03-20','YYYY-MM-DD'),'TMMEOSEFRP.BR95','20C18PrFiGaB203JaSm150500M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-15','YYYY-MM-DD'),TO_DATE('2023-03-21','YYYY-MM-DD'),'TMMEOSEFRP.BR95','20C18PrFiGaB203EmJo220801F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-16','YYYY-MM-DD'),TO_DATE('2023-03-22','YYYY-MM-DD'),'TMMEOSEFRP.BR95','21C18PrFiGaB203LiWi011299M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-17','YYYY-MM-DD'),TO_DATE('2023-03-23','YYYY-MM-DD'),'TMMEOSEFRP.BR95','21C18PrFiGaB203SoBr101100F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-18','YYYY-MM-DD'),TO_DATE('2023-03-24','YYYY-MM-DD'),'TMMEOSEFRP.BR95','22C18PrFiGaB203NoJo050302M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-19','YYYY-MM-DD'),TO_DATE('2023-03-25','YYYY-MM-DD'),'TMMEOSEFRP.BR95','20C18PrFiGaB203MiGa300700F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-20','YYYY-MM-DD'),TO_DATE('2023-03-26','YYYY-MM-DD'),'TMMEOSEFRP.BR95','21C18PrFiGaB203EtMa150901M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-21','YYYY-MM-DD'),TO_DATE('2023-03-27','YYYY-MM-DD'),'TMMEOSEFRP.BR95','22C18PrFiGaB203AvDa280600F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-22','YYYY-MM-DD'),TO_DATE('2023-03-28','YYYY-MM-DD'),'CNANS.TA10','19C18PrFiGaB203MaRo120498M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-23','YYYY-MM-DD'),TO_DATE('2023-03-29','YYYY-MM-DD'),'CNANS.TA10','23C18PrFiGaB203IsHe231002F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-24','YYYY-MM-DD'),TO_DATE('2023-03-30','YYYY-MM-DD'),'CNANS.TA10','20C18PrFiGaB203LuWi140201M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-25','YYYY-MM-DD'),TO_DATE('2023-03-31','YYYY-MM-DD'),'CNANS.TA10','19C18PrFiGaB203AmLe200799F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-26','YYYY-MM-DD'),TO_DATE('2023-04-01','YYYY-MM-DD'),'CNANS.TA10','21C18PrFiGaB203AiLe180502M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-27','YYYY-MM-DD'),TO_DATE('2023-04-02','YYYY-MM-DD'),'CNANS.TA10','20C18PrFiGaB203ChWa301200F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-28','YYYY-MM-DD'),TO_DATE('2023-04-03','YYYY-MM-DD'),'CNANS.TA10','21C18PrFiGaB203JaHa170899M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-29','YYYY-MM-DD'),TO_DATE('2023-04-04','YYYY-MM-DD'),'CNANS.TA10','22C18PrFiGaB203MiYo260301F' FROM dual
UNION ALL SELECT TO_DATE('2023-03-30','YYYY-MM-DD'),TO_DATE('2023-04-05','YYYY-MM-DD'),'CNANS.TA10','20D24DrGeMaB204LoKi301100M' FROM dual
UNION ALL SELECT TO_DATE('2023-03-31','YYYY-MM-DD'),TO_DATE('2023-04-06','YYYY-MM-DD'),'CNANS.TA10','20D24DrGeMaB204BeWh120400M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-01','YYYY-MM-DD'),TO_DATE('2023-04-07','YYYY-MM-DD'),'CPTATALV.AH06','19D24DrGeMaB204GrTh150599F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-02','YYYY-MM-DD'),TO_DATE('2023-04-08','YYYY-MM-DD'),'CPTATALV.AH06','21D24DrGeMaB204SaMa240701M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-03','YYYY-MM-DD'),TO_DATE('2023-04-09','YYYY-MM-DD'),'CPTATALV.AH06','22D24DrGeMaB204AbAn301200F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-04','YYYY-MM-DD'),TO_DATE('2023-04-10','YYYY-MM-DD'),'CPTATALV.AH06','20D24DrGeMaB204HeTa051002M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-05','YYYY-MM-DD'),TO_DATE('2023-04-11','YYYY-MM-DD'),'CPTATALV.AH06','21D24DrGeMaB204ElTh181101F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-06','YYYY-MM-DD'),TO_DATE('2023-04-12','YYYY-MM-DD'),'CPTATALV.AH06','21D24DrGeMaB204WyJa280600M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-07','YYYY-MM-DD'),TO_DATE('2023-04-13','YYYY-MM-DD'),'CPTATALV.AH06','22D24DrGeMaB204ScHa220900F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-08','YYYY-MM-DD'),TO_DATE('2023-04-14','YYYY-MM-DD'),'CPTATALV.AH06','21D24DrGeMaB204OwMa150102M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-09','YYYY-MM-DD'),TO_DATE('2023-04-15','YYYY-MM-DD'),'CPTATALV.AH06','19D24DrGeMaB204ViTh100498F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-10','YYYY-MM-DD'),TO_DATE('2023-04-16','YYYY-MM-DD'),'CPTATALV.AH06','20D24DrGeMaB204AlRo280201M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-11','YYYY-MM-DD'),TO_DATE('2023-04-17','YYYY-MM-DD'),'JTCRHESC14','21D24DrGeMaB204SoCl160300F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-12','YYYY-MM-DD'),TO_DATE('2023-04-18','YYYY-MM-DD'),'JTCRHESC14','20D24DrGeMaB204AnRo201101M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-13','YYYY-MM-DD'),TO_DATE('2023-04-19','YYYY-MM-DD'),'JTCRHESC14','21D24DrGeMaB204LiLe100800F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-14','YYYY-MM-DD'),TO_DATE('2023-04-20','YYYY-MM-DD'),'JTCRHESC14','22D24DrGeMaB204LuLe301200M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-15','YYYY-MM-DD'),TO_DATE('2023-04-21','YYYY-MM-DD'),'JTCRHESC14','20D24DrGeMaB204EmAl170902F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-16','YYYY-MM-DD'),TO_DATE('2023-04-22','YYYY-MM-DD'),'JTCRHESC14','21D24DrGeMaB204JaWa090301M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-17','YYYY-MM-DD'),TO_DATE('2023-04-23','YYYY-MM-DD'),'JTCRHESC14','20D24DrGeMaB204OlPe100500F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-18','YYYY-MM-DD'),TO_DATE('2023-04-24','YYYY-MM-DD'),'JTCRHESC14','20D24DrGeMaB204SeGr190201M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-19','YYYY-MM-DD'),TO_DATE('2023-04-25','YYYY-MM-DD'),'JTCRHESC14','21D24DrGeMaB204AmHi250699F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-20','YYYY-MM-DD'),TO_DATE('2023-04-26','YYYY-MM-DD'),'JTCRHESC14','22D24DrGeMaB204LuSc300700M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-21','YYYY-MM-DD'),TO_DATE('2023-04-27','YYYY-MM-DD'),'PFDAWEMC17','21A35PrUmRoC301MiAd141000F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-22','YYYY-MM-DD'),TO_DATE('2023-04-28','YYYY-MM-DD'),'PFDAWEMC17','22A35PrUmRoC301AlNe010301M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-23','YYYY-MM-DD'),TO_DATE('2023-04-29','YYYY-MM-DD'),'PFDAWEMC17','21A35PrUmRoC301ChCa050400F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-24','YYYY-MM-DD'),TO_DATE('2023-04-30','YYYY-MM-DD'),'PFDAWEMC17','20A35PrUmRoC301BeSa231101M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-25','YYYY-MM-DD'),TO_DATE('2023-05-01','YYYY-MM-DD'),'PFDAWEMC17','20A35PrUmRoC301SoPe151202F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-26','YYYY-MM-DD'),TO_DATE('2023-05-02','YYYY-MM-DD'),'PFDAWEMC17','21A35PrUmRoC301WiMo200900M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-27','YYYY-MM-DD'),TO_DATE('2023-05-03','YYYY-MM-DD'),'PFDAWEMC17','20A35PrUmRoC301HaRo280300F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-28','YYYY-MM-DD'),TO_DATE('2023-05-04','YYYY-MM-DD'),'PFDAWEMC17','21A35PrUmRoC301JaRe101001M' FROM dual
UNION ALL SELECT TO_DATE('2023-04-29','YYYY-MM-DD'),TO_DATE('2023-05-05','YYYY-MM-DD'),'PFDAWEMC17','20A35PrUmRoC301ElCo190899F' FROM dual
UNION ALL SELECT TO_DATE('2023-04-30','YYYY-MM-DD'),TO_DATE('2023-05-06','YYYY-MM-DD'),'PFDAWEMC17','21A35PrUmRoC301MaBe220700M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-01','YYYY-MM-DD'),TO_DATE('2023-05-07','YYYY-MM-DD'),'TCPLBRW.KE88','22A35PrUmRoC301LiMu180500F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-02','YYYY-MM-DD'),TO_DATE('2023-05-08','YYYY-MM-DD'),'TCPLBRW.KE88','20A35PrUmRoC301DaDi010101M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-03','YYYY-MM-DD'),TO_DATE('2023-05-09','YYYY-MM-DD'),'TCPLBRW.KE88','21A35PrUmRoC301NaRa120602F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-04','YYYY-MM-DD'),TO_DATE('2023-05-10','YYYY-MM-DD'),'TCPLBRW.KE88','20A35PrUmRoC301OlPe250100M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-05','YYYY-MM-DD'),TO_DATE('2023-05-11','YYYY-MM-DD'),'TCPLBRW.KE88','21A35PrUmRoC301MiTa150399F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-06','YYYY-MM-DD'),TO_DATE('2023-05-12','YYYY-MM-DD'),'TCPLBRW.KE88','22A35PrUmRoC301ElBr100601M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-07','YYYY-MM-DD'),TO_DATE('2023-05-13','YYYY-MM-DD'),'TCPLBRW.KE88','20A35PrUmRoC301ChJo201000F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-08','YYYY-MM-DD'),TO_DATE('2023-05-14','YYYY-MM-DD'),'TCPLBRW.KE88','21A35PrUmRoC301LuMi121202M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-09','YYYY-MM-DD'),TO_DATE('2023-05-15','YYYY-MM-DD'),'TCPLBRW.KE88','22A35PrUmRoC301SoDa300501F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-10','YYYY-MM-DD'),TO_DATE('2023-05-16','YYYY-MM-DD'),'TCPLBRW.KE88','20A35PrUmRoC301JaWi280700M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-11','YYYY-MM-DD'),TO_DATE('2023-05-17','YYYY-MM-DD'),'HFDPERFR04','21A35PrUmRoC301LiMo041199F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-12','YYYY-MM-DD'),TO_DATE('2023-05-18','YYYY-MM-DD'),'HFDPERFR04','22A35PrUmRoC301BeTa140301M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-13','YYYY-MM-DD'),TO_DATE('2023-05-19','YYYY-MM-DD'),'HFDPERFR04','20A35PrUmRoC301AvCl250400F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-14','YYYY-MM-DD'),TO_DATE('2023-05-20','YYYY-MM-DD'),'HFDPERFR04','21A35PrUmRoC301WyRo190200M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-15','YYYY-MM-DD'),TO_DATE('2023-05-21','YYYY-MM-DD'),'HFDPERFR04','20A35PrUmRoC301HaLe150801F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-16','YYYY-MM-DD'),TO_DATE('2023-05-22','YYYY-MM-DD'),'HFDPERFR04','21A35PrUmRoC301JaHa111298M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-17','YYYY-MM-DD'),TO_DATE('2023-05-23','YYYY-MM-DD'),'HFDPERFR04','22A35PrUmRoC301ScAd180902F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-18','YYYY-MM-DD'),TO_DATE('2023-05-24','YYYY-MM-DD'),'HFDPERFR04','21A35PrUmRoC301DaWi300700M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-19','YYYY-MM-DD'),TO_DATE('2023-05-25','YYYY-MM-DD'),'HFDPERFR04','22A35PrUmRoC301EvYo221100F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-20','YYYY-MM-DD'),TO_DATE('2023-05-26','YYYY-MM-DD'),'HFDPERFR04','20A35PrUmRoC301GaTu090401M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-21','YYYY-MM-DD'),TO_DATE('2023-05-27','YYYY-MM-DD'),'EJJOBL17','20A35PrUmRoC301AmGa050900F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-22','YYYY-MM-DD'),TO_DATE('2023-05-28','YYYY-MM-DD'),'EJJOBL17','21A35PrUmRoC301SaMa200299M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-23','YYYY-MM-DD'),TO_DATE('2023-05-29','YYYY-MM-DD'),'EJJOBL17','22A35PrUmRoC301ScLo150101F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-24','YYYY-MM-DD'),TO_DATE('2023-05-30','YYYY-MM-DD'),'EJJOBL17','20B31MrIaThC302NoLe220600M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-25','YYYY-MM-DD'),TO_DATE('2023-05-31','YYYY-MM-DD'),'EJJOBL17','21B31MrIaThC302ChAl100502F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-26','YYYY-MM-DD'),TO_DATE('2023-06-01','YYYY-MM-DD'),'EJJOBL17','20B31MrIaThC302HeWr301101M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-27','YYYY-MM-DD'),TO_DATE('2023-06-02','YYYY-MM-DD'),'EJJOBL17','22B31MrIaThC302LiSc130300F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-28','YYYY-MM-DD'),TO_DATE('2023-06-03','YYYY-MM-DD'),'EJJOBL17','21B31MrIaThC302AiYo290400M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-29','YYYY-MM-DD'),TO_DATE('2023-06-04','YYYY-MM-DD'),'EJJOBL17','20B31MrIaThC302MaHa141299F' FROM dual
UNION ALL SELECT TO_DATE('2023-05-30','YYYY-MM-DD'),TO_DATE('2023-06-05','YYYY-MM-DD'),'EJJOBL17','21B31MrIaThC302EtTh011002M' FROM dual
UNION ALL SELECT TO_DATE('2023-05-31','YYYY-MM-DD'),TO_DATE('2023-06-06','YYYY-MM-DD'),'YDKJE&BKYSI15','20B31MrIaThC302GrGr250100M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-01','YYYY-MM-DD'),TO_DATE('2023-06-07','YYYY-MM-DD'),'YDKJE&BKYSI15','22B31MrIaThC302ViMo070701F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-02','YYYY-MM-DD'),TO_DATE('2023-06-08','YYYY-MM-DD'),'YDKJE&BKYSI15','20B31MrIaThC302JaHa161100M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-03','YYYY-MM-DD'),TO_DATE('2023-06-09','YYYY-MM-DD'),'YDKJE&BKYSI15','21B31MrIaThC302SoTa300601F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-04','YYYY-MM-DD'),TO_DATE('2023-06-10','YYYY-MM-DD'),'YDKJE&BKYSI15','20B31MrIaThC302SeCl100302M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-05','YYYY-MM-DD'),TO_DATE('2023-06-11','YYYY-MM-DD'),'YDKJE&BKYSI15','22B31MrIaThC302AvRo220899F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-06','YYYY-MM-DD'),TO_DATE('2023-06-12','YYYY-MM-DD'),'YDKJE&BKYSI15','20B31MrIaThC302LoLe100501M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-07','YYYY-MM-DD'),TO_DATE('2023-06-13','YYYY-MM-DD'),'YDKJE&BKYSI15','21B31MrIaThC302EmMa150199F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-08','YYYY-MM-DD'),TO_DATE('2023-06-14','YYYY-MM-DD'),'YDKJE&BKYSI15','22B31MrIaThC302MaPe300600M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-09','YYYY-MM-DD'),TO_DATE('2023-06-15','YYYY-MM-DD'),'YDKJE&BKYSI15','20B31MrIaThC302ScJo200900F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-10','YYYY-MM-DD'),TO_DATE('2023-06-16','YYYY-MM-DD'),'LSALBE09','21B31MrIaThC302LiSm050402M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-11','YYYY-MM-DD'),TO_DATE('2023-06-17','YYYY-MM-DD'),'LSALBE09','20B31MrIaThC302ChTa250799F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-12','YYYY-MM-DD'),TO_DATE('2023-06-18','YYYY-MM-DD'),'LSALBE09','22B31MrIaThC302JaWa151201M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-13','YYYY-MM-DD'),TO_DATE('2023-06-19','YYYY-MM-DD'),'LSALBE09','21B31MrIaThC302OlHe101000F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-14','YYYY-MM-DD'),TO_DATE('2023-06-20','YYYY-MM-DD'),'LSALBE09','20B31MrIaThC302DaYo080301M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-15','YYYY-MM-DD'),TO_DATE('2023-06-21','YYYY-MM-DD'),'LSALBE09','21B31MrIaThC302AvKi180499F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-16','YYYY-MM-DD'),TO_DATE('2023-06-22','YYYY-MM-DD'),'LSALBE09','22B31MrIaThC302HaLo140200F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-17','YYYY-MM-DD'),TO_DATE('2023-06-23','YYYY-MM-DD'),'LSALBE09','20B31MrIaThC302LuSc150501M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-18','YYYY-MM-DD'),TO_DATE('2023-06-24','YYYY-MM-DD'),'LSALBE09','21B31MrIaThC302BeGo301200M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-19','YYYY-MM-DD'),TO_DATE('2023-06-25','YYYY-MM-DD'),'LSALBE09','20B31MrIaThC302ElRa181102F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-20','YYYY-MM-DD'),TO_DATE('2023-06-26','YYYY-MM-DD'),'CTCIGALAMC15','21B31MrIaThC302NaCo200699M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-21','YYYY-MM-DD'),TO_DATE('2023-06-27','YYYY-MM-DD'),'CTCIGALAMC15','22B31MrIaThC302MiRe250800F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-22','YYYY-MM-DD'),TO_DATE('2023-06-28','YYYY-MM-DD'),'CTCIGALAMC15','20C29PrJeClC303IsWr170501F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-23','YYYY-MM-DD'),TO_DATE('2023-06-29','YYYY-MM-DD'),'CTCIGALAMC15','21C29PrJeClC303MaBr090999M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-24','YYYY-MM-DD'),TO_DATE('2023-06-30','YYYY-MM-DD'),'CTCIGALAMC15','22C29PrJeClC303SoRe250400F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-25','YYYY-MM-DD'),TO_DATE('2023-07-01','YYYY-MM-DD'),'CTCIGALAMC15','20C29PrJeClC303JaCo141000M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-26','YYYY-MM-DD'),TO_DATE('2023-07-02','YYYY-MM-DD'),'CTCIGALAMC15','21C29PrJeClC303AvCa300101F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-27','YYYY-MM-DD'),TO_DATE('2023-07-03','YYYY-MM-DD'),'CTCIGALAMC15','20C29PrJeClC303ElHa050802M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-28','YYYY-MM-DD'),TO_DATE('2023-07-04','YYYY-MM-DD'),'CTCIGALAMC15','22C29PrJeClC303MiHa121299F' FROM dual
UNION ALL SELECT TO_DATE('2023-06-29','YYYY-MM-DD'),TO_DATE('2023-07-05','YYYY-MM-DD'),'CTCIGALAMC15','21C29PrJeClC303LuAd180600M' FROM dual
UNION ALL SELECT TO_DATE('2023-06-30','YYYY-MM-DD'),TO_DATE('2023-07-06','YYYY-MM-DD'),'SAIOCPHAAB96','20C29PrJeClC303HaBe151101F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-01','YYYY-MM-DD'),TO_DATE('2023-07-07','YYYY-MM-DD'),'SAIOCPHAAB96','21C29PrJeClC303JaGa240300M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-02','YYYY-MM-DD'),TO_DATE('2023-07-08','YYYY-MM-DD'),'SAIOCPHAAB96','22C29PrJeClC303ChLo050202F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-03','YYYY-MM-DD'),TO_DATE('2023-07-09','YYYY-MM-DD'),'SAIOCPHAAB96','20C29PrJeClC303HePa290701M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-04','YYYY-MM-DD'),TO_DATE('2023-07-10','YYYY-MM-DD'),'SAIOCPHAAB96','21C29PrJeClC303EvTu010899F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-05','YYYY-MM-DD'),TO_DATE('2023-07-11','YYYY-MM-DD'),'SAIOCPHAAB96','22C29PrJeClC303NaRi231200M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-06','YYYY-MM-DD'),TO_DATE('2023-07-12','YYYY-MM-DD'),'SAIOCPHAAB96','20C29PrJeClC303ScHa090500F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-07','YYYY-MM-DD'),TO_DATE('2023-07-13','YYYY-MM-DD'),'SAIOCPHAAB96','21C29PrJeClC303GaSc301001M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-08','YYYY-MM-DD'),TO_DATE('2023-07-14','YYYY-MM-DD'),'SAIOCPHAAB96','20C29PrJeClC303AvJo160201F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-09','YYYY-MM-DD'),TO_DATE('2023-07-15','YYYY-MM-DD'),'SAIOCPHAAB96','21C29PrJeClC303LuLe300699M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-10','YYYY-MM-DD'),TO_DATE('2023-07-16','YYYY-MM-DD'),'OSCABSI12','22C29PrJeClC303MiWh120400F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-11','YYYY-MM-DD'),TO_DATE('2023-07-17','YYYY-MM-DD'),'OSCABSI12','20C29PrJeClC303SaHa250800M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-12','YYYY-MM-DD'),TO_DATE('2023-07-18','YYYY-MM-DD'),'OSCABSI12','21C29PrJeClC303EmMa051101F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-13','YYYY-MM-DD'),TO_DATE('2023-07-19','YYYY-MM-DD'),'OSCABSI12','20C29PrJeClC303NoBr210102M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-14','YYYY-MM-DD'),TO_DATE('2023-07-20','YYYY-MM-DD'),'OSCABSI12','22C29PrJeClC303JaYo141200M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-15','YYYY-MM-DD'),TO_DATE('2023-07-21','YYYY-MM-DD'),'OSCABSI12','21C29PrJeClC303GrSc170399F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-16','YYYY-MM-DD'),TO_DATE('2023-07-22','YYYY-MM-DD'),'OSCABSI12','20C29PrJeClC303EtHa300901M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-17','YYYY-MM-DD'),TO_DATE('2023-07-23','YYYY-MM-DD'),'OSCABSI12','21C29PrJeClC303ChPe110500F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-18','YYYY-MM-DD'),TO_DATE('2023-07-24','YYYY-MM-DD'),'OSCABSI12','22C29PrJeClC303WiAd091001M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-19','YYYY-MM-DD'),TO_DATE('2023-07-25','YYYY-MM-DD'),'OSCABSI12','20B27DrZaCoD402LiLe181200F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-20','YYYY-MM-DD'),TO_DATE('2023-07-26','YYYY-MM-DD'),'PPJOBE99','21B27DrZaCoD402BeWa270602M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-21','YYYY-MM-DD'),TO_DATE('2023-07-27','YYYY-MM-DD'),'PPJOBE99','22B27DrZaCoD402HaMa140799F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-22','YYYY-MM-DD'),TO_DATE('2023-07-28','YYYY-MM-DD'),'PPJOBE99','20B27DrZaCoD402LoWi150401M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-23','YYYY-MM-DD'),TO_DATE('2023-07-29','YYYY-MM-DD'),'PPJOBE99','21B27DrZaCoD402ScKi270300F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-24','YYYY-MM-DD'),TO_DATE('2023-07-30','YYYY-MM-DD'),'PPJOBE99','20B27DrZaCoD402ElGr201001M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-25','YYYY-MM-DD'),TO_DATE('2023-07-31','YYYY-MM-DD'),'PPJOBE99','21B27DrZaCoD402HaWr020999F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-26','YYYY-MM-DD'),TO_DATE('2023-08-01','YYYY-MM-DD'),'PPJOBE99','22B27DrZaCoD402AiLe050500M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-27','YYYY-MM-DD'),TO_DATE('2023-08-02','YYYY-MM-DD'),'PPJOBE99','20B27DrZaCoD402GrHa090402F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-28','YYYY-MM-DD'),TO_DATE('2023-08-03','YYYY-MM-DD'),'PPJOBE99','21B27DrZaCoD402ChTa111101F' FROM dual
UNION ALL SELECT TO_DATE('2023-07-29','YYYY-MM-DD'),TO_DATE('2023-08-04','YYYY-MM-DD'),'PPJOBE99','20B27DrZaCoD402LoSc140100M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-30','YYYY-MM-DD'),TO_DATE('2023-08-05','YYYY-MM-DD'),'CCSTMC04','22B27DrZaCoD402OlJo030702M' FROM dual
UNION ALL SELECT TO_DATE('2023-07-31','YYYY-MM-DD'),TO_DATE('2023-08-06','YYYY-MM-DD'),'CCSTMC04','20B27DrZaCoD402SoAd240699F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-01','YYYY-MM-DD'),TO_DATE('2023-08-07','YYYY-MM-DD'),'CCSTMC04','21B27DrZaCoD402AvTu160900F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-02','YYYY-MM-DD'),TO_DATE('2023-08-08','YYYY-MM-DD'),'CCSTMC04','20B27DrZaCoD402HeWi081202M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-03','YYYY-MM-DD'),TO_DATE('2023-08-09','YYYY-MM-DD'),'CCSTMC04','21B27DrZaCoD402MiKi270301F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-04','YYYY-MM-DD'),TO_DATE('2023-08-10','YYYY-MM-DD'),'CCSTMC04','22B27DrZaCoD402JaMa120800M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-05','YYYY-MM-DD'),TO_DATE('2023-08-11','YYYY-MM-DD'),'CCSTMC04','20B27DrZaCoD402AmHa140200F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-06','YYYY-MM-DD'),TO_DATE('2023-08-12','YYYY-MM-DD'),'CCSTMC04','21B27DrZaCoD402ElSc210501M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-07','YYYY-MM-DD'),TO_DATE('2023-08-13','YYYY-MM-DD'),'CCSTMC04','22B27DrZaCoD402LuCa300102M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-08','YYYY-MM-DD'),TO_DATE('2023-08-14','YYYY-MM-DD'),'CCSTMC04','20B27DrZaCoD402HaWr020300F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-09','YYYY-MM-DD'),TO_DATE('2023-08-15','YYYY-MM-DD'),'TLPIMIKE10','20B27DrZaCoD402NoAd151000M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-10','YYYY-MM-DD'),TO_DATE('2023-08-16','YYYY-MM-DD'),'TLPIMIKE10','21B27DrZaCoD402IsHa300501F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-11','YYYY-MM-DD'),TO_DATE('2023-08-17','YYYY-MM-DD'),'TLPIMIKE10','22B27DrZaCoD402ElCl220999M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-12','YYYY-MM-DD'),TO_DATE('2023-08-18','YYYY-MM-DD'),'TLPIMIKE10','20B27DrZaCoD402MiBr180700F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-13','YYYY-MM-DD'),TO_DATE('2023-08-19','YYYY-MM-DD'),'TLPIMIKE10','21C23DrOsMaD403WiHa121102M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-14','YYYY-MM-DD'),TO_DATE('2023-08-20','YYYY-MM-DD'),'TLPIMIKE10','22C23DrOsMaD403EmKi250601F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-15','YYYY-MM-DD'),TO_DATE('2023-08-21','YYYY-MM-DD'),'TLPIMIKE10','20C23DrOsMaD403JaLe090399M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-16','YYYY-MM-DD'),TO_DATE('2023-08-22','YYYY-MM-DD'),'TLPIMIKE10','21C23DrOsMaD403GrSc011201F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-17','YYYY-MM-DD'),TO_DATE('2023-08-23','YYYY-MM-DD'),'TLPIMIKE10','22C23DrOsMaD403SaTu190800M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-18','YYYY-MM-DD'),TO_DATE('2023-08-24','YYYY-MM-DD'),'TLPIMIKE10','20C23DrOsMaD403HaWr110102F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-19','YYYY-MM-DD'),TO_DATE('2023-08-25','YYYY-MM-DD'),'UNPW.RIST98','21C23DrOsMaD403BeMi150400M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-20','YYYY-MM-DD'),TO_DATE('2023-08-26','YYYY-MM-DD'),'UNPW.RIST98','22C23DrOsMaD403ScRo280299F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-21','YYYY-MM-DD'),TO_DATE('2023-08-27','YYYY-MM-DD'),'UNPW.RIST98','20C23DrOsMaD403LuRo050701M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-22','YYYY-MM-DD'),TO_DATE('2023-08-28','YYYY-MM-DD'),'UNPW.RIST98','21C23DrOsMaD403ChMa140500F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-23','YYYY-MM-DD'),TO_DATE('2023-08-29','YYYY-MM-DD'),'UNPW.RIST98','22C23DrOsMaD403DaLe180901M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-24','YYYY-MM-DD'),TO_DATE('2023-08-30','YYYY-MM-DD'),'UNPW.RIST98','20C23DrOsMaD403LiGo101199F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-25','YYYY-MM-DD'),TO_DATE('2023-08-31','YYYY-MM-DD'),'UNPW.RIST98','20C23DrOsMaD403JaEv051200M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-26','YYYY-MM-DD'),TO_DATE('2023-09-01','YYYY-MM-DD'),'UNPW.RIST98','21C23DrOsMaD403ElLe170601F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-27','YYYY-MM-DD'),TO_DATE('2023-09-02','YYYY-MM-DD'),'UNPW.RIST98','22C23DrOsMaD403MiJo230799M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-28','YYYY-MM-DD'),TO_DATE('2023-09-03','YYYY-MM-DD'),'UNPW.RIST98','20C23DrOsMaD403AmWi040900F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-29','YYYY-MM-DD'),TO_DATE('2023-09-04','YYYY-MM-DD'),'TCCROC.MA11','21C23DrOsMaD403EtHa260502M' FROM dual
UNION ALL SELECT TO_DATE('2023-08-30','YYYY-MM-DD'),TO_DATE('2023-09-05','YYYY-MM-DD'),'TCCROC.MA11','22C23DrOsMaD403HaTa290301F' FROM dual
UNION ALL SELECT TO_DATE('2023-08-31','YYYY-MM-DD'),TO_DATE('2023-09-06','YYYY-MM-DD'),'TCCROC.MA11','20C23DrOsMaD403OlMi151099M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-01','YYYY-MM-DD'),TO_DATE('2023-09-07','YYYY-MM-DD'),'TCCROC.MA11','21C23DrOsMaD403ChLo120200F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-02','YYYY-MM-DD'),TO_DATE('2023-09-08','YYYY-MM-DD'),'TCCROC.MA11','22C23DrOsMaD403BeMa181101M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-03','YYYY-MM-DD'),TO_DATE('2023-09-09','YYYY-MM-DD'),'TCCROC.MA11','20A36DrUmRoE501GrWa010102F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-04','YYYY-MM-DD'),TO_DATE('2023-09-10','YYYY-MM-DD'),'TCCROC.MA11','21A36DrUmRoE501SaBr170899M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-05','YYYY-MM-DD'),TO_DATE('2023-09-11','YYYY-MM-DD'),'TCCROC.MA11','22A36DrUmRoE501EmGa300401F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-06','YYYY-MM-DD'),TO_DATE('2023-09-12','YYYY-MM-DD'),'TCCROC.MA11','20A36DrUmRoE501DaTh260302M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-07','YYYY-MM-DD'),TO_DATE('2023-09-13','YYYY-MM-DD'),'TCCROC.MA11','21A36DrUmRoE501LiRo021200F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-08','YYYY-MM-DD'),TO_DATE('2023-09-14','YYYY-MM-DD'),'DLIAGO16','22A36DrUmRoE501ElSm140600M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-09','YYYY-MM-DD'),TO_DATE('2023-09-15','YYYY-MM-DD'),'DLIAGO16','20A36DrUmRoE501HaYo190999F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-10','YYYY-MM-DD'),TO_DATE('2023-09-16','YYYY-MM-DD'),'DLIAGO16','20A36DrUmRoE501OlKi150500F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-11','YYYY-MM-DD'),TO_DATE('2023-09-17','YYYY-MM-DD'),'DLIAGO16','21A36DrUmRoE501ElNe111199M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-12','YYYY-MM-DD'),TO_DATE('2023-09-18','YYYY-MM-DD'),'DLIAGO16','22A36DrUmRoE501GrCa300301F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-13','YYYY-MM-DD'),TO_DATE('2023-09-19','YYYY-MM-DD'),'DLIAGO16','20A36DrUmRoE501NoBr180702M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-14','YYYY-MM-DD'),TO_DATE('2023-09-20','YYYY-MM-DD'),'DLIAGO16','21A36DrUmRoE501MiHi090900F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-15','YYYY-MM-DD'),TO_DATE('2023-09-21','YYYY-MM-DD'),'DLIAGO16','22A36DrUmRoE501LuMi231201M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-16','YYYY-MM-DD'),TO_DATE('2023-09-22','YYYY-MM-DD'),'DLIAGO16','20A36DrUmRoE501ChWo280899F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-17','YYYY-MM-DD'),TO_DATE('2023-09-23','YYYY-MM-DD'),'DLIAGO16','21A36DrUmRoE501JaLe050100M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-18','YYYY-MM-DD'),TO_DATE('2023-09-24','YYYY-MM-DD'),'ITTTOCMISI12','22A36DrUmRoE501LiRi190402F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-19','YYYY-MM-DD'),TO_DATE('2023-09-25','YYYY-MM-DD'),'ITTTOCMISI12','20A36DrUmRoE501DaPa101000M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-20','YYYY-MM-DD'),TO_DATE('2023-09-26','YYYY-MM-DD'),'ITTTOCMISI12','21A36DrUmRoE501ScTu300701F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-21','YYYY-MM-DD'),TO_DATE('2023-09-27','YYYY-MM-DD'),'ITTTOCMISI12','22A36DrUmRoE501BeDa120299M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-22','YYYY-MM-DD'),TO_DATE('2023-09-28','YYYY-MM-DD'),'ITTTOCMISI12','20A36DrUmRoE501AmJo151200F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-23','YYYY-MM-DD'),TO_DATE('2023-09-29','YYYY-MM-DD'),'ITTTOCMISI12','21A36DrUmRoE501ElMa180102M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-24','YYYY-MM-DD'),TO_DATE('2023-09-30','YYYY-MM-DD'),'ITTTOCMISI12','22A36DrUmRoE501AvRo220900F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-25','YYYY-MM-DD'),TO_DATE('2023-10-01','YYYY-MM-DD'),'ITTTOCMISI12','20A36DrUmRoE501SaGr251199M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-26','YYYY-MM-DD'),TO_DATE('2023-10-02','YYYY-MM-DD'),'ITTTOCMISI12','20A36DrUmRoE501AlCa010500M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-27','YYYY-MM-DD'),TO_DATE('2023-10-03','YYYY-MM-DD'),'ITTTOCMISI12','21A36DrUmRoE501SoDa120999F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-28','YYYY-MM-DD'),TO_DATE('2023-10-04','YYYY-MM-DD'),'AEAPMICO05','22A36DrUmRoE501NoMi190401M' FROM dual
UNION ALL SELECT TO_DATE('2023-09-29','YYYY-MM-DD'),TO_DATE('2023-10-05','YYYY-MM-DD'),'AEAPMICO05','20A36DrUmRoE501IsAn240102F' FROM dual
UNION ALL SELECT TO_DATE('2023-09-30','YYYY-MM-DD'),TO_DATE('2023-10-06','YYYY-MM-DD'),'AEAPMICO05','21A36DrUmRoE501EtJo111200M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-01','YYYY-MM-DD'),TO_DATE('2023-10-07','YYYY-MM-DD'),'AEAPMICO05','22A36DrUmRoE501MiRo280801F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-02','YYYY-MM-DD'),TO_DATE('2023-10-08','YYYY-MM-DD'),'AEAPMICO05','20A36DrUmRoE501LiWi150302M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-03','YYYY-MM-DD'),TO_DATE('2023-10-09','YYYY-MM-DD'),'AEAPMICO05','21A36DrUmRoE501AmLe301100F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-04','YYYY-MM-DD'),TO_DATE('2023-10-10','YYYY-MM-DD'),'AEAPMICO05','22A36DrUmRoE501LuTh050701M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-05','YYYY-MM-DD'),TO_DATE('2023-10-11','YYYY-MM-DD'),'AEAPMICO05','20A36DrUmRoE501ChMa201099F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-06','YYYY-MM-DD'),TO_DATE('2023-10-12','YYYY-MM-DD'),'AEAPMICO05','21A36DrUmRoE501BeWh290600M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-07','YYYY-MM-DD'),TO_DATE('2023-10-13','YYYY-MM-DD'),'AEAPMICO05','22C20DrOsMaE503GrJa120501F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-08','YYYY-MM-DD'),TO_DATE('2023-10-14','YYYY-MM-DD'),'JTGPDOCR08','20C20DrOsMaE503SaHa040202M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-09','YYYY-MM-DD'),TO_DATE('2023-10-15','YYYY-MM-DD'),'JTGPDOCR08','21C20DrOsMaE503LiMa160800F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-10','YYYY-MM-DD'),TO_DATE('2023-10-16','YYYY-MM-DD'),'JTGPDOCR08','22C20DrOsMaE503ElTh300901M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-11','YYYY-MM-DD'),TO_DATE('2023-10-17','YYYY-MM-DD'),'JTGPDOCR08','20C20DrOsMaE503HaGa180399F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-12','YYYY-MM-DD'),TO_DATE('2023-10-18','YYYY-MM-DD'),'JTGPDOCR08','20C20DrOsMaE503OlKi140300F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-13','YYYY-MM-DD'),TO_DATE('2023-10-19','YYYY-MM-DD'),'JTGPDOCR08','21C20DrOsMaE503ElNe110499M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-14','YYYY-MM-DD'),TO_DATE('2023-10-20','YYYY-MM-DD'),'JTGPDOCR08','22C20DrOsMaE503GrCa300701F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-15','YYYY-MM-DD'),TO_DATE('2023-10-21','YYYY-MM-DD'),'JTGPDOCR08','20C20DrOsMaE503NoBr050502M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-16','YYYY-MM-DD'),TO_DATE('2023-10-22','YYYY-MM-DD'),'JTGPDOCR08','21C20DrOsMaE503MiHi091000F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-17','YYYY-MM-DD'),TO_DATE('2023-10-23','YYYY-MM-DD'),'JTGPDOCR08','22C20DrOsMaE503LuMi211201M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-18','YYYY-MM-DD'),TO_DATE('2023-10-24','YYYY-MM-DD'),'RITDOECMAFO18','20C20DrOsMaE503ChWo120899F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-19','YYYY-MM-DD'),TO_DATE('2023-10-25','YYYY-MM-DD'),'RITDOECMAFO18','21C20DrOsMaE503JaLe030200M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-20','YYYY-MM-DD'),TO_DATE('2023-10-26','YYYY-MM-DD'),'RITDOECMAFO18','22C20DrOsMaE503LiRi190102F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-21','YYYY-MM-DD'),TO_DATE('2023-10-27','YYYY-MM-DD'),'RITDOECMAFO18','20C20DrOsMaE503DaPa141000M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-22','YYYY-MM-DD'),TO_DATE('2023-10-28','YYYY-MM-DD'),'RITDOECMAFO18','21C20DrOsMaE503ScTu010901F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-23','YYYY-MM-DD'),TO_DATE('2023-10-29','YYYY-MM-DD'),'RITDOECMAFO18','22C20DrOsMaE503BeDa110699M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-24','YYYY-MM-DD'),TO_DATE('2023-10-30','YYYY-MM-DD'),'RITDOECMAFO18','20C20DrOsMaE503AmJo241100F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-25','YYYY-MM-DD'),TO_DATE('2023-10-31','YYYY-MM-DD'),'RITDOECMAFO18','21A32PrKaMoF601ElMa200202M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-26','YYYY-MM-DD'),TO_DATE('2023-11-01','YYYY-MM-DD'),'RITDOECMAFO18','22A32PrKaMoF601AvRo220300F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-27','YYYY-MM-DD'),TO_DATE('2023-11-02','YYYY-MM-DD'),'RITDOECMAFO18','20A32PrKaMoF601SaGr091199M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-28','YYYY-MM-DD'),TO_DATE('2023-11-03','YYYY-MM-DD'),'TDOETDONO13','20A32PrKaMoF601GrWh150600F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-29','YYYY-MM-DD'),TO_DATE('2023-11-04','YYYY-MM-DD'),'TDOETDONO13','21A32PrKaMoF601WiLe140999M' FROM dual
UNION ALL SELECT TO_DATE('2023-10-30','YYYY-MM-DD'),TO_DATE('2023-11-05','YYYY-MM-DD'),'TDOETDONO13','22A32PrKaMoF601LiCa200301F' FROM dual
UNION ALL SELECT TO_DATE('2023-10-31','YYYY-MM-DD'),TO_DATE('2023-11-06','YYYY-MM-DD'),'TDOETDONO13','20A32PrKaMoF601JaHa301102M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-01','YYYY-MM-DD'),TO_DATE('2023-11-07','YYYY-MM-DD'),'TDOETDONO13','21A32PrKaMoF601NoMa091000M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-02','YYYY-MM-DD'),TO_DATE('2023-11-08','YYYY-MM-DD'),'TDOETDONO13','22A32PrKaMoF601EmYo180101F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-03','YYYY-MM-DD'),TO_DATE('2023-11-09','YYYY-MM-DD'),'TDOETDONO13','20A32PrKaMoF601EtRo250799M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-04','YYYY-MM-DD'),TO_DATE('2023-11-10','YYYY-MM-DD'),'TDOETDONO13','21A32PrKaMoF601SoDa121200F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-05','YYYY-MM-DD'),TO_DATE('2023-11-11','YYYY-MM-DD'),'TDOETDONO13','22A32PrKaMoF601ElNe170402M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-06','YYYY-MM-DD'),TO_DATE('2023-11-12','YYYY-MM-DD'),'TDOETDONO13','20A32PrKaMoF601BeLe210599M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-07','YYYY-MM-DD'),TO_DATE('2023-11-13','YYYY-MM-DD'),'AROSE11','21A32PrKaMoF601MiMo060900F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-08','YYYY-MM-DD'),TO_DATE('2023-11-14','YYYY-MM-DD'),'AROSE11','22A32PrKaMoF601SaSc040601M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-09','YYYY-MM-DD'),TO_DATE('2023-11-15','YYYY-MM-DD'),'AROSE11','20A32PrKaMoF601AvHi150202F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-10','YYYY-MM-DD'),TO_DATE('2023-11-16','YYYY-MM-DD'),'AROSE11','21A32PrKaMoF601DaTh241000M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-11','YYYY-MM-DD'),TO_DATE('2023-11-17','YYYY-MM-DD'),'AROSE11','22A32PrKaMoF601ChMa300301F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-12','YYYY-MM-DD'),TO_DATE('2023-11-18','YYYY-MM-DD'),'AROSE11','20A32PrKaMoF601LuGo110899M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-13','YYYY-MM-DD'),TO_DATE('2023-11-19','YYYY-MM-DD'),'AROSE11','20A32PrKaMoF601LiHa020500M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-14','YYYY-MM-DD'),TO_DATE('2023-11-20','YYYY-MM-DD'),'AROSE11','21A32PrKaMoF601EmJo150399F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-15','YYYY-MM-DD'),TO_DATE('2023-11-21','YYYY-MM-DD'),'AROSE11','22A32PrKaMoF601NoWi221101M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-16','YYYY-MM-DD'),TO_DATE('2023-11-22','YYYY-MM-DD'),'AROSE11','20A32PrKaMoF601AvBr140202F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-17','YYYY-MM-DD'),TO_DATE('2023-11-23','YYYY-MM-DD'),'AIFOCADAL.PO10','21A32PrKaMoF601EtGa080900M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-18','YYYY-MM-DD'),TO_DATE('2023-11-24','YYYY-MM-DD'),'AIFOCADAL.PO10','22A32PrKaMoF601IsMa300601F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-19','YYYY-MM-DD'),TO_DATE('2023-11-25','YYYY-MM-DD'),'AIFOCADAL.PO10','20A32PrKaMoF601LuLe050402M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-20','YYYY-MM-DD'),TO_DATE('2023-11-26','YYYY-MM-DD'),'AIFOCADAL.PO10','21A32PrKaMoF601SoTh181299F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-21','YYYY-MM-DD'),TO_DATE('2023-11-27','YYYY-MM-DD'),'AIFOCADAL.PO10','22A32PrKaMoF601BeHa110800M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-22','YYYY-MM-DD'),TO_DATE('2023-11-28','YYYY-MM-DD'),'AIFOCADAL.PO10','20A32PrKaMoF601MiCl251001F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-23','YYYY-MM-DD'),TO_DATE('2023-11-29','YYYY-MM-DD'),'AIFOCADAL.PO10','21A32PrKaMoF601SaRo140302M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-24','YYYY-MM-DD'),TO_DATE('2023-11-30','YYYY-MM-DD'),'AIFOCADAL.PO10','22B19DrXeNeF602ChLe090500F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-25','YYYY-MM-DD'),TO_DATE('2023-12-01','YYYY-MM-DD'),'AIFOCADAL.PO10','20B19DrXeNeF602JaYo160701M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-26','YYYY-MM-DD'),TO_DATE('2023-12-02','YYYY-MM-DD'),'AIFOCADAL.PO10','21B19DrXeNeF602GrHe010199F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-27','YYYY-MM-DD'),TO_DATE('2023-12-03','YYYY-MM-DD'),'DDACADAHA12','22B19DrXeNeF602ElKi051202M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-28','YYYY-MM-DD'),TO_DATE('2023-12-04','YYYY-MM-DD'),'DDACADAHA12','20B19DrXeNeF602HaAl131100F' FROM dual
UNION ALL SELECT TO_DATE('2023-11-29','YYYY-MM-DD'),TO_DATE('2023-12-05','YYYY-MM-DD'),'DDACADAHA12','20B19DrXeNeF602WiWr070300M' FROM dual
UNION ALL SELECT TO_DATE('2023-11-30','YYYY-MM-DD'),TO_DATE('2023-12-06','YYYY-MM-DD'),'DDACADAHA12','21B19DrXeNeF602AmSc140599F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-01','YYYY-MM-DD'),TO_DATE('2023-12-07','YYYY-MM-DD'),'DDACADAHA12','22B19DrXeNeF602DaHi230901M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-02','YYYY-MM-DD'),TO_DATE('2023-12-08','YYYY-MM-DD'),'DDACADAHA12','20B19DrXeNeF602SoTo120102F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-03','YYYY-MM-DD'),TO_DATE('2023-12-09','YYYY-MM-DD'),'DDACADAHA12','21B19DrXeNeF602ElLe041200M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-04','YYYY-MM-DD'),TO_DATE('2023-12-10','YYYY-MM-DD'),'DDACADAHA12','22B19DrXeNeF602IsRi210601F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-05','YYYY-MM-DD'),TO_DATE('2023-12-11','YYYY-MM-DD'),'DDACADAHA12','20B19DrXeNeF602LuDa291002M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-06','YYYY-MM-DD'),TO_DATE('2023-12-12','YYYY-MM-DD'),'DDACADAHA12','21B19DrXeNeF602MiMa260299F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-07','YYYY-MM-DD'),TO_DATE('2023-12-13','YYYY-MM-DD'),'HFJKASI05','22B19DrXeNeF602JaGa150800M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-08','YYYY-MM-DD'),TO_DATE('2023-12-14','YYYY-MM-DD'),'HFJKASI05','20B19DrXeNeF602GrLo301101F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-09','YYYY-MM-DD'),TO_DATE('2023-12-15','YYYY-MM-DD'),'HFJKASI05','21B19DrXeNeF602BeJo100402M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-10','YYYY-MM-DD'),TO_DATE('2023-12-16','YYYY-MM-DD'),'HFJKASI05','22B19DrXeNeF602ChLe190799F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-11','YYYY-MM-DD'),TO_DATE('2023-12-17','YYYY-MM-DD'),'HFJKASI05','20C21PrWaCrF603SaMa280900M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-12','YYYY-MM-DD'),TO_DATE('2023-12-18','YYYY-MM-DD'),'HFJKASI05','21C21PrWaCrF603AvAn250501F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-13','YYYY-MM-DD'),TO_DATE('2023-12-19','YYYY-MM-DD'),'HFJKASI05','22C21PrWaCrF603NoTh180202M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-14','YYYY-MM-DD'),TO_DATE('2023-12-20','YYYY-MM-DD'),'HFJKASI05','20C21PrWaCrF603LiRo070100F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-15','YYYY-MM-DD'),TO_DATE('2023-12-21','YYYY-MM-DD'),'HFJKASI05','20C21PrWaCrF603MiPa010400F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-16','YYYY-MM-DD'),TO_DATE('2023-12-22','YYYY-MM-DD'),'HFJKASI05','21C21PrWaCrF603AlEv120699M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-17','YYYY-MM-DD'),TO_DATE('2023-12-23','YYYY-MM-DD'),'PCCERMA15','22C21PrWaCrF603BeWa190801M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-18','YYYY-MM-DD'),TO_DATE('2023-12-24','YYYY-MM-DD'),'PCCERMA15','20C21PrWaCrF603GrGo301202F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-19','YYYY-MM-DD'),TO_DATE('2023-12-25','YYYY-MM-DD'),'PCCERMA15','21C21PrWaCrF603NoHa171100M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-20','YYYY-MM-DD'),TO_DATE('2023-12-26','YYYY-MM-DD'),'PCCERMA15','22C21PrWaCrF603OlLe220901F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-21','YYYY-MM-DD'),TO_DATE('2023-12-27','YYYY-MM-DD'),'PCCERMA15','20C21PrWaCrF603LuMa030202M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-22','YYYY-MM-DD'),TO_DATE('2023-12-28','YYYY-MM-DD'),'PCCERMA15','21C21PrWaCrF603IsRo101099F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-23','YYYY-MM-DD'),TO_DATE('2023-12-29','YYYY-MM-DD'),'PCCERMA15','22C21PrWaCrF603SaDa260700M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-24','YYYY-MM-DD'),TO_DATE('2023-12-30','YYYY-MM-DD'),'PCCERMA15','20C21PrWaCrF603EmTh140501F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-25','YYYY-MM-DD'),TO_DATE('2023-12-31','YYYY-MM-DD'),'PCCERMA15','21C21PrWaCrF603JaJo120302M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-26','YYYY-MM-DD'),TO_DATE('2024-01-01','YYYY-MM-DD'),'PCCERMA15','22C21PrWaCrF603AvWi010100F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-27','YYYY-MM-DD'),TO_DATE('2024-01-02','YYYY-MM-DD'),'TEOSLTRHA09','20C21PrWaCrF603ElBr090401M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-28','YYYY-MM-DD'),TO_DATE('2024-01-03','YYYY-MM-DD'),'TEOSLTRHA09','21C21PrWaCrF603SoMa050899F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-29','YYYY-MM-DD'),TO_DATE('2024-01-04','YYYY-MM-DD'),'TEOSLTRHA09','22C21PrWaCrF603LiLe111102M' FROM dual
UNION ALL SELECT TO_DATE('2023-12-30','YYYY-MM-DD'),TO_DATE('2024-01-05','YYYY-MM-DD'),'TEOSLTRHA09','20A26PrHaWiG701ChHe201200F' FROM dual
UNION ALL SELECT TO_DATE('2023-12-31','YYYY-MM-DD'),TO_DATE('2024-01-06','YYYY-MM-DD'),'TEOSLTRHA09','20A26PrHaWiG701WiWr010500M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-01','YYYY-MM-DD'),TO_DATE('2024-01-07','YYYY-MM-DD'),'TEOSLTRHA09','21A26PrHaWiG701OlSc100499F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-02','YYYY-MM-DD'),TO_DATE('2024-01-08','YYYY-MM-DD'),'TEOSLTRHA09','22A26PrHaWiG701DaHi211101M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-01-09','YYYY-MM-DD'),'TEOSLTRHA09','20A26PrHaWiG701SoTo180302F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-04','YYYY-MM-DD'),TO_DATE('2024-01-10','YYYY-MM-DD'),'TEOSLTRHA09','21A26PrHaWiG701ElLe090700M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-05','YYYY-MM-DD'),TO_DATE('2024-01-11','YYYY-MM-DD'),'TEOSLTRHA09','22A26PrHaWiG701IsRi300801F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-06','YYYY-MM-DD'),TO_DATE('2024-01-12','YYYY-MM-DD'),'SIACRWA18','20A26PrHaWiG701LuDa220602M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-07','YYYY-MM-DD'),TO_DATE('2024-01-13','YYYY-MM-DD'),'SIACRWA18','21A26PrHaWiG701MiMa141099F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-08','YYYY-MM-DD'),TO_DATE('2024-01-14','YYYY-MM-DD'),'SIACRWA18','22A26PrHaWiG701JaGa061200M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-09','YYYY-MM-DD'),TO_DATE('2024-01-15','YYYY-MM-DD'),'SIACRWA18','20A26PrHaWiG701GrLo010901F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-10','YYYY-MM-DD'),TO_DATE('2024-01-16','YYYY-MM-DD'),'SIACRWA18','21A26PrHaWiG701BeJo170202M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-11','YYYY-MM-DD'),TO_DATE('2024-01-17','YYYY-MM-DD'),'SIACRWA18','22A26PrHaWiG701ChLe210199F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-12','YYYY-MM-DD'),TO_DATE('2024-01-18','YYYY-MM-DD'),'SIACRWA18','20A26PrHaWiG701SaMa291100M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-13','YYYY-MM-DD'),TO_DATE('2024-01-19','YYYY-MM-DD'),'SIACRWA18','21A26PrHaWiG701AvAn200501F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-14','YYYY-MM-DD'),TO_DATE('2024-01-20','YYYY-MM-DD'),'SIACRWA18','22A26PrHaWiG701NoTh080402M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-15','YYYY-MM-DD'),TO_DATE('2024-01-21','YYYY-MM-DD'),'COADDAA.PA13','20A26PrHaWiG701LiRo150300F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-16','YYYY-MM-DD'),TO_DATE('2024-01-22','YYYY-MM-DD'),'COADDAA.PA13','20A26PrHaWiG701MiTu110400F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-17','YYYY-MM-DD'),TO_DATE('2024-01-23','YYYY-MM-DD'),'COADDAA.PA13','21A26PrHaWiG701AlEv240699M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-18','YYYY-MM-DD'),TO_DATE('2024-01-24','YYYY-MM-DD'),'COADDAA.PA13','22A26PrHaWiG701BeWa050901M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-19','YYYY-MM-DD'),TO_DATE('2024-01-25','YYYY-MM-DD'),'COADDAA.PA13','20A26PrHaWiG701GrGo291202F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-20','YYYY-MM-DD'),TO_DATE('2024-01-26','YYYY-MM-DD'),'COADDAA.PA13','21A26PrHaWiG701NoHa141100M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-21','YYYY-MM-DD'),TO_DATE('2024-01-27','YYYY-MM-DD'),'COADDAA.PA13','22A26PrHaWiG701OlLe100701F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-22','YYYY-MM-DD'),TO_DATE('2024-01-28','YYYY-MM-DD'),'COADDAA.PA13','20A26PrHaWiG701LuMa240202M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-23','YYYY-MM-DD'),TO_DATE('2024-01-29','YYYY-MM-DD'),'COADDAA.PA13','21B33MrLaWhG702IsRo171099F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-24','YYYY-MM-DD'),TO_DATE('2024-01-30','YYYY-MM-DD'),'FPLURA15','22B33MrLaWhG702SaDa310800M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-25','YYYY-MM-DD'),TO_DATE('2024-01-31','YYYY-MM-DD'),'FPLURA15','20B33MrLaWhG702EmTh120301F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-26','YYYY-MM-DD'),TO_DATE('2024-02-01','YYYY-MM-DD'),'FPLURA15','21B33MrLaWhG702JaJo200502M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-27','YYYY-MM-DD'),TO_DATE('2024-02-02','YYYY-MM-DD'),'FPLURA15','22B33MrLaWhG702AvWi020900F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-28','YYYY-MM-DD'),TO_DATE('2024-02-03','YYYY-MM-DD'),'FPLURA15','20B33MrLaWhG702ElBr291001M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-29','YYYY-MM-DD'),TO_DATE('2024-02-04','YYYY-MM-DD'),'FPLURA15','21B33MrLaWhG702SoMa060899F' FROM dual
UNION ALL SELECT TO_DATE('2024-01-30','YYYY-MM-DD'),TO_DATE('2024-02-05','YYYY-MM-DD'),'FPLURA15','22B33MrLaWhG702LiLe190602M' FROM dual
UNION ALL SELECT TO_DATE('2024-01-31','YYYY-MM-DD'),TO_DATE('2024-02-06','YYYY-MM-DD'),'FPLURA15','20B33MrLaWhG702ChHe121200F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-01','YYYY-MM-DD'),TO_DATE('2024-02-07','YYYY-MM-DD'),'FPLURA15','20B33MrLaWhG702JaAn150100M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-02','YYYY-MM-DD'),TO_DATE('2024-02-08','YYYY-MM-DD'),'ITMLWPANC.MÜ16','21B33MrLaWhG702ChMa250999F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-03','YYYY-MM-DD'),TO_DATE('2024-02-09','YYYY-MM-DD'),'ITMLWPANC.MÜ16','22B33MrLaWhG702DaWi301101M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-04','YYYY-MM-DD'),TO_DATE('2024-02-10','YYYY-MM-DD'),'ITMLWPANC.MÜ16','20B33MrLaWhG702SoTh110302F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-05','YYYY-MM-DD'),TO_DATE('2024-02-11','YYYY-MM-DD'),'ITMLWPANC.MÜ16','21B33MrLaWhG702ElYo050500M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-06','YYYY-MM-DD'),TO_DATE('2024-02-12','YYYY-MM-DD'),'ITMLWPANC.MÜ16','22B33MrLaWhG702IsLe171001F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-07','YYYY-MM-DD'),TO_DATE('2024-02-13','YYYY-MM-DD'),'ITMLWPANC.MÜ16','20B33MrLaWhG702LuBr210702M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-08','YYYY-MM-DD'),TO_DATE('2024-02-14','YYYY-MM-DD'),'ITMLWPANC.MÜ16','21B33MrLaWhG702MiRo141299F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-09','YYYY-MM-DD'),TO_DATE('2024-02-15','YYYY-MM-DD'),'ITMLWPANC.MÜ16','22B33MrLaWhG702SaGa280200M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-10','YYYY-MM-DD'),TO_DATE('2024-02-16','YYYY-MM-DD'),'ITMLWPANC.MÜ16','20B33MrLaWhG702EmMa060801F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-11','YYYY-MM-DD'),TO_DATE('2024-02-17','YYYY-MM-DD'),'PGSCCH14','21B33MrLaWhG702JaJo211102M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-12','YYYY-MM-DD'),TO_DATE('2024-02-18','YYYY-MM-DD'),'PGSCCH14','22B33MrLaWhG702AvWi220400F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-13','YYYY-MM-DD'),TO_DATE('2024-02-19','YYYY-MM-DD'),'PGSCCH14','20B33MrLaWhG702ElBr030501M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-14','YYYY-MM-DD'),TO_DATE('2024-02-20','YYYY-MM-DD'),'PGSCCH14','21B33MrLaWhG702SoMa110699F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-15','YYYY-MM-DD'),TO_DATE('2024-02-21','YYYY-MM-DD'),'PGSCCH14','22B33MrLaWhG702LiLe120902M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-16','YYYY-MM-DD'),TO_DATE('2024-02-22','YYYY-MM-DD'),'PGSCCH14','20B33MrLaWhG702ChHe220300F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-17','YYYY-MM-DD'),TO_DATE('2024-02-23','YYYY-MM-DD'),'PGSCCH14','20B33MrLaWhG702OlSm100100M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-18','YYYY-MM-DD'),TO_DATE('2024-02-24','YYYY-MM-DD'),'PGSCCH14','21B33MrLaWhG702EmJo200999F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-19','YYYY-MM-DD'),TO_DATE('2024-02-25','YYYY-MM-DD'),'PGSCCH14','22B33MrLaWhG702JaWi150301M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-20','YYYY-MM-DD'),TO_DATE('2024-02-26','YYYY-MM-DD'),'TPPDATH19','20B33MrLaWhG702AvBr220602F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-21','YYYY-MM-DD'),TO_DATE('2024-02-27','YYYY-MM-DD'),'TPPDATH19','21B33MrLaWhG702MaGa051100M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-22','YYYY-MM-DD'),TO_DATE('2024-02-28','YYYY-MM-DD'),'TPPDATH19','22B30MsZaCoI902IsMa171201F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-23','YYYY-MM-DD'),TO_DATE('2024-02-29','YYYY-MM-DD'),'TPPDATH19','20B30MsZaCoI902WiRo300502M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-24','YYYY-MM-DD'),TO_DATE('2024-03-01','YYYY-MM-DD'),'TPPDATH19','21B30MsZaCoI902MiWi120899F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-25','YYYY-MM-DD'),TO_DATE('2024-03-02','YYYY-MM-DD'),'TPPDATH19','22B30MsZaCoI902ElTh250700M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-26','YYYY-MM-DD'),TO_DATE('2024-03-03','YYYY-MM-DD'),'TPPDATH19','20B30MsZaCoI902GrTa090401F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-27','YYYY-MM-DD'),TO_DATE('2024-03-04','YYYY-MM-DD'),'TPPDATH19','21B30MsZaCoI902BeLe141002M' FROM dual
UNION ALL SELECT TO_DATE('2024-02-28','YYYY-MM-DD'),TO_DATE('2024-03-05','YYYY-MM-DD'),'TPPDATH19','22B30MsZaCoI902ChMa301199F' FROM dual
UNION ALL SELECT TO_DATE('2024-02-29','YYYY-MM-DD'),TO_DATE('2024-03-06','YYYY-MM-DD'),'ITDMPATA05','20B30MsZaCoI902JaDa220200M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-01','YYYY-MM-DD'),TO_DATE('2024-03-07','YYYY-MM-DD'),'ITDMPATA05','21B30MsZaCoI902AvHe050901F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-02','YYYY-MM-DD'),TO_DATE('2024-03-08','YYYY-MM-DD'),'ITDMPATA05','22B30MsZaCoI902LuLe170102M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-03','YYYY-MM-DD'),TO_DATE('2024-03-09','YYYY-MM-DD'),'ITDMPATA05','20B30MsZaCoI902SoWi180300F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-04','YYYY-MM-DD'),TO_DATE('2024-03-10','YYYY-MM-DD'),'ITDMPATA05','20B30MsZaCoI902JaMa110400M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-05','YYYY-MM-DD'),TO_DATE('2024-03-11','YYYY-MM-DD'),'ITDMPATA05','21B30MsZaCoI902ChTh250999F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-06','YYYY-MM-DD'),TO_DATE('2024-03-12','YYYY-MM-DD'),'ITDMPATA05','22B30MsZaCoI902DaBr140801M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-07','YYYY-MM-DD'),TO_DATE('2024-03-13','YYYY-MM-DD'),'ITDMPATA05','20B30MsZaCoI902SoJo110302F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-08','YYYY-MM-DD'),TO_DATE('2024-03-14','YYYY-MM-DD'),'ITDMPATA05','21B30MsZaCoI902ElLe150500M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-09','YYYY-MM-DD'),TO_DATE('2024-03-15','YYYY-MM-DD'),'DSFSJOGR19','22B30MsZaCoI902IsSm270601F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-10','YYYY-MM-DD'),TO_DATE('2024-03-16','YYYY-MM-DD'),'DSFSJOGR19','20B30MsZaCoI902LuDa301002M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-11','YYYY-MM-DD'),TO_DATE('2024-03-17','YYYY-MM-DD'),'DSFSJOGR19','21B30MsZaCoI902MiGa191299F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-12','YYYY-MM-DD'),TO_DATE('2024-03-18','YYYY-MM-DD'),'DSFSJOGR19','22B30MsZaCoI902SaMa090200M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-13','YYYY-MM-DD'),TO_DATE('2024-03-19','YYYY-MM-DD'),'DSFSJOGR19','20B30MsZaCoI902EmTa240101F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-14','YYYY-MM-DD'),TO_DATE('2024-03-20','YYYY-MM-DD'),'DSFSJOGR19','21B30MsZaCoI902JaWi020702M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-15','YYYY-MM-DD'),TO_DATE('2024-03-21','YYYY-MM-DD'),'DSFSJOGR19','22B30MsZaCoI902AvJo181100F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-16','YYYY-MM-DD'),TO_DATE('2024-03-22','YYYY-MM-DD'),'DSFSJOGR19','20B30MsZaCoI902ElWh150801M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-17','YYYY-MM-DD'),TO_DATE('2024-03-23','YYYY-MM-DD'),'DSFSJOGR19','21B30MsZaCoI902SoHa290399F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-18','YYYY-MM-DD'),TO_DATE('2024-03-24','YYYY-MM-DD'),'TGPLALA.A.DO15','22B30MsZaCoI902LiCl061002M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-19','YYYY-MM-DD'),TO_DATE('2024-03-25','YYYY-MM-DD'),'TGPLALA.A.DO15','20B30MsZaCoI902ChMa020900F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-20','YYYY-MM-DD'),TO_DATE('2024-03-26','YYYY-MM-DD'),'TGPLALA.A.DO15','20A25PrAlJoA101EmJo150202F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-21','YYYY-MM-DD'),TO_DATE('2024-03-27','YYYY-MM-DD'),'TGPLALA.A.DO15','20A25PrAlJoA101DaSm200601M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-22','YYYY-MM-DD'),TO_DATE('2024-03-28','YYYY-MM-DD'),'TGPLALA.A.DO15','20A25PrAlJoA101SaWi250302F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-23','YYYY-MM-DD'),TO_DATE('2024-03-29','YYYY-MM-DD'),'TGPLALA.A.DO15','20A25PrAlJoA101JoBr111100M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-24','YYYY-MM-DD'),TO_DATE('2024-03-30','YYYY-MM-DD'),'TGPLALA.A.DO15','20A25PrAlJoA101JeDa300702F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-25','YYYY-MM-DD'),TO_DATE('2024-03-31','YYYY-MM-DD'),'TGPLALA.A.DO15','20A25PrAlJoA101DaMi140801M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-26','YYYY-MM-DD'),TO_DATE('2024-04-01','YYYY-MM-DD'),'TGPLALA.A.DO15','20A25PrAlJoA101LaWi120402F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-27','YYYY-MM-DD'),TO_DATE('2024-04-02','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101MiTa080901M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-28','YYYY-MM-DD'),TO_DATE('2024-04-03','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101OlAn190502F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-29','YYYY-MM-DD'),TO_DATE('2024-04-04','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101JoTh221200M' FROM dual
UNION ALL SELECT TO_DATE('2024-03-30','YYYY-MM-DD'),TO_DATE('2024-04-05','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101SoJa300101F' FROM dual
UNION ALL SELECT TO_DATE('2024-03-31','YYYY-MM-DD'),TO_DATE('2024-04-06','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101JaWh031002M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-01','YYYY-MM-DD'),TO_DATE('2024-04-07','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101ChHa151202F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-02','YYYY-MM-DD'),TO_DATE('2024-04-08','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101EtMa060401M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-03','YYYY-MM-DD'),TO_DATE('2024-04-09','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101MiTh280701F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-04','YYYY-MM-DD'),TO_DATE('2024-04-10','YYYY-MM-DD'),'LSHOKA20','20A25PrAlJoA101BeGa090802M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-05','YYYY-MM-DD'),TO_DATE('2024-04-11','YYYY-MM-DD'),'MLYANNG19','20A25PrAlJoA101LiMa160300F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-06','YYYY-MM-DD'),TO_DATE('2024-04-12','YYYY-MM-DD'),'MLYANNG19','20A25PrAlJoA101JaRo040902M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-07','YYYY-MM-DD'),TO_DATE('2024-04-13','YYYY-MM-DD'),'MLYANNG19','20A25PrAlJoA101ChCl111101F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-08','YYYY-MM-DD'),TO_DATE('2024-04-14','YYYY-MM-DD'),'MLYANNG19','21A25PrAlJoA101EtWi120102M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-09','YYYY-MM-DD'),TO_DATE('2024-04-15','YYYY-MM-DD'),'MLYANNG19','21A25PrAlJoA101AvJo250501F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-10','YYYY-MM-DD'),TO_DATE('2024-04-16','YYYY-MM-DD'),'MLYANNG19','21A25PrAlJoA101MiSm070302F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-11','YYYY-MM-DD'),TO_DATE('2024-04-17','YYYY-MM-DD'),'MLYANNG19','21A25PrAlJoA101LiBr201100M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-12','YYYY-MM-DD'),TO_DATE('2024-04-18','YYYY-MM-DD'),'MLYANNG19','21B30PrBrSmA102HaDa150602F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-13','YYYY-MM-DD'),TO_DATE('2024-04-19','YYYY-MM-DD'),'MLYANNG19','21B30PrBrSmA102NoTa300901M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-14','YYYY-MM-DD'),TO_DATE('2024-04-20','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102IsMa280202F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-15','YYYY-MM-DD'),TO_DATE('2024-04-21','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102LuGa120801M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-16','YYYY-MM-DD'),TO_DATE('2024-04-22','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102ChHe040502F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-17','YYYY-MM-DD'),TO_DATE('2024-04-23','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102MaWi141200M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-18','YYYY-MM-DD'),TO_DATE('2024-04-24','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102AmAn180301F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-19','YYYY-MM-DD'),TO_DATE('2024-04-25','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102ElCl210702M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-20','YYYY-MM-DD'),TO_DATE('2024-04-26','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102ElLe031002F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-21','YYYY-MM-DD'),TO_DATE('2024-04-27','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102AlRo090401M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-22','YYYY-MM-DD'),TO_DATE('2024-04-28','YYYY-MM-DD'),'TAOSMAL.AB15','21B30PrBrSmA102ScLe151101F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-23','YYYY-MM-DD'),TO_DATE('2024-04-29','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102DaYo270802M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-24','YYYY-MM-DD'),TO_DATE('2024-04-30','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102GrAl100200F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-25','YYYY-MM-DD'),TO_DATE('2024-05-01','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102WiKi200902M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-26','YYYY-MM-DD'),TO_DATE('2024-05-02','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102SoWr010101F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-27','YYYY-MM-DD'),TO_DATE('2024-05-03','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102JaAd150302M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-28','YYYY-MM-DD'),TO_DATE('2024-05-04','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102MiTh101201F' FROM dual
UNION ALL SELECT TO_DATE('2024-04-29','YYYY-MM-DD'),TO_DATE('2024-05-05','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102JaWh221100M' FROM dual
UNION ALL SELECT TO_DATE('2024-04-30','YYYY-MM-DD'),TO_DATE('2024-05-06','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102EmHa300502F' FROM dual
UNION ALL SELECT TO_DATE('2024-05-01','YYYY-MM-DD'),TO_DATE('2024-05-07','YYYY-MM-DD'),'CDJEHU10','21B30PrBrSmA102WiMa180701M' FROM dual;
SELECT * FROM University_Borrowed_Books
TRUNCATE TABLE University_Borrowed_Books
