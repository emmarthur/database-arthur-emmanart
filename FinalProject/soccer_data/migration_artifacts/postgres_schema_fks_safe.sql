SET search_path TO hw3, public;

INSERT INTO Student (StudentID, StudentName, Major) VALUES
  (101, 'Maya Patel', 'CS'),
  (102, 'Daniel Wong', 'DS'),
  (103, 'Taylor Alison', 'CS');

INSERT INTO Course (CourseID, CourseName) VALUES
  ('CS101', 'Intro to CS'),
  ('CS205', 'DBMS'),
  ('MATH201', 'Discrete Math');

INSERT INTO Instructor (InstructorID, InstructorName) VALUES
  (1, 'Lee'),
  (2, 'Smith'),
  (3, 'Brown');

INSERT INTO CourseOffering (CourseID, Semester, InstructorID) VALUES
  ('CS101', 'Fall 2025', 1),
  ('CS205', 'Fall 2025', 2),
  ('MATH201', 'Fall 2025', 3);

INSERT INTO Enrollment (StudentID, CourseID, Semester, Grade) VALUES
  (101, 'CS101', 'Fall 2025', 'A'),
  (101, 'CS205', 'Fall 2025', 'B+'),
  (102, 'CS205', 'Fall 2025', 'A-'),
  (103, 'CS101', 'Fall 2025', 'B'),
  (103, 'MATH201', 'Fall 2025', 'A');