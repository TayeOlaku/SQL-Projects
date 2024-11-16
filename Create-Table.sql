CREATE TABLE Student_DB
(
Student_Id  Varchar2(25),  
First_Name Varchar2(50),    
Last_Name Varchar2(50),  
Gender Char(6), 
Age int,
Ethnicity Varchar2(25),   
Email Varchar2(50),  
Major Varchar2(50),   
Gpa Number (1,2),
Enrollment_Date Date, 
Graduation_Date Date, 
Current_Semester Number,   
Housing_Status  Varchar2(10),  
Academic_Level Varchar2(25),  
Nationality Varchar2(50),    
Secondary_Language Varchar2(50)
);

ALTER TABLE Student_DB
DROP Column Graduation_Date;

ALTER TABLE Student_DB
MODIFY Gpa Number (3, 2);

ALTER TABLE Student_DB
MODIFY Nationality Varchar2(60);

DROP TABLE Student_DB

/*Write a query to set the Major as 'Medcine', for the Student with Student_id UOT/2021/002 to the existing table Student_DB. */

UPDATE Student_DB
SET Major = 'Medcine'
WHERE STUDENT_ID = 'UOT/2021/002';

--1. Retrieve all records from the student database.
SELECT * FROM Student_DB;

--2.    Select the names and email addresses of all students.

SELECT 
FIRST_NAME,
EMAIL
FROM Student_DB;

--3.    Count the total number of students in the database.

SELECT COUNT(*)
FROM Student_DB;

SELECT COUNT(DISTINCT STUDENT_ID) AS Unique_Students 
FROM Student_DB;

--4.    Find students who are majoring in "Nursing & Midwivfery."

SELECT *
FROM Student_DB
WHERE MAJOR = 'Nursing Science';

--5.    Get the average GPA of all students.
SELECT AVG(Gpa)
FROM Student_DB;

--6.    List all students who are 19 years old.
SELECT * 
FROM Student_DB
WHERE AGE = 19;

--7.    Select the unique values for the Housing_Status column.
SELECT unique(Housing_Status)
FROM Student_DB;

--8.    Retrieve students whose Secondary_Language is null.
SELECT * 
FROM Student_DB
where Secondary_Language is NULL;

--9.    Count the number of female students in the database.
SELECT COUNT(*) AS GENDER_COUNT
FROM Student_DB
WHERE GENDER = 'Female';

--10.    Find the student with the highest GPA.
SELECT MAX(Gpa)
FROM Student_DB;

--11.    List all students who enrolled after March 30, 2021.
SELECT *
FROM Student_DB
WHERE ENROLLMENT_DATE > '2021\03\30';

--12.    Group students by Academic_Level and count how many are in each level.
SELECT 
ACADEMIC_LEVEL,
COUNT(ACADEMIC_LEVEL) 
FROM Student_DB
GROUP BY ACADEMIC_LEVEL 
ORDER BY ACADEMIC_LEVEL ASC;

SELECT ACADEMIC_LEVEL, COUNT(*) AS Student_Count
FROM Student_DB
GROUP BY ACADEMIC_LEVEL;

--14.    Find students who have a GPA above 3.0 and are majoring in "Nursing Science."
SELECT * FROM Student_DB
WHERE Gpa > 3.0 AND MAJOR = 'Nursing Science';

--17.    List all students along with their respective Nationality, and filter out students without a nationality.
SELECT *
FROM Student_DB
WHERE NATIONALITY IS NOT NULL;

SELECT 
STUDENT_ID,
FIRST_NAME,
LAST_NAME,
NATIONALITY
FROM Student_DB
WHERE NATIONALITY IS NOT NULL

--18.    Create a view to show students who are about to graduate in the next semester.
SELECT *
FROM Student_DB
WHERE CURRENT_SEMESTER = 8

--19.    Write a query to find students who have not declared a Secondary_Language
SELECT * FROM Student_DB
WHERE SECONDARY_LANGUAGE IS NULL OR SECONDARY_LANGUAGE = '';

--20.    Use a subquery to find students whose GPAs are above the average GPA of the database.
SELECT *
FROM Student_DB
WHERE GPA > (SELECT AVG(GPA) FROM Student_DB)
ORDER BY Gpa ASC; -- to double check as the avg Gpa is 2.43

--21.    Implement a CTE to categorize students based on their GPA into "Low," "Medium," and "High."
WITH GpaCategorized AS (
    SELECT 
        STUDENT_ID,
        FIRST_NAME,
        Gpa,
        CASE 
            WHEN GPA < 2.4 THEN 'Low'
            WHEN GPA BETWEEN 2.4 AND 3.49 THEN 'Medium'
            ELSE 'High'
        END AS gpa_category
    FROM Student_DB
)
SELECT *
FROM GPACategorized
ORDER BY Gpa_category, Gpa ASC;

--22.    Write a query that updates the Housing_Status for students based on their Academic_Level.
UPDATE Student_DB
SET Housing_Status = CASE
    WHEN ACADEMIC_LEVEL = 'Freshman' THEN 'Dorm'
    WHEN ACADEMIC_LEVEL = 'Sophomore' THEN 'Dorm'
    WHEN ACADEMIC_LEVEL = 'Junior' THEN 'Apartment'
    ELSE 'Off-Campus'
END;

--23.    Find the percentage of students in each Housing_Status category.
SELECT 
HOUSING_STATUS,
(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Student_DB)) AS Percentage_Count
FROM Student_DB
GROUP BY HOUSING_STATUS 
ORDER BY Percentage_Count ASC;

--24. Create a report that summarizes the average GPA by Academic_Level.
SELECT 
    Academic_Level,
    AVG(GPA) AS Average_GPA
FROM 
    Student_DB
GROUP BY 
    Academic_Level;
    
--25.    Retrieve the top 5 students with the highest GPAs and their majors.
SELECT MAX(Gpa) as Gpa_rank
FROM Student_DB
ORDER by Gpa_rank;



