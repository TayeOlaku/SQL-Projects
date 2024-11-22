-- Create the Student_DB table to store student information
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

-- Drop the Graduation_Date column from the table as it is no longer needed
ALTER TABLE Student_DB
DROP Column Graduation_Date;

-- Modify the Gpa column to allow a higher precision (2 digits after the decimal)
ALTER TABLE Student_DB
MODIFY Gpa Number (3, 2);

-- Increase the length of the Nationality column to allow more characters
ALTER TABLE Student_DB
MODIFY Nationality Varchar2(60);

/*Write a query to set the Major as 'Medcine', for the Student with Student_id UOT/2021/002 to the existing table Student_DB. */
-- Update the Major for a specific student (Student_Id: UOT/2021/002) to 'Medicine'
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

--Filtering Data
--4.    Find students who are majoring in "Nursing & Midwivfery."
SELECT *
FROM Student_DB
WHERE MAJOR = 'Nursing Science';

--5.    List all students who are 19 years old.
SELECT * 
FROM Student_DB
WHERE AGE = 19;

--6.    Retrieve students whose Secondary_Language is null.
SELECT * 
FROM Student_DB
WHERE Secondary_Language IS NULL OR Secondary_Language = '';

--7.    Find students with a GPA between 3.5 and 4.0
SELECT * 
FROM Student_DB
WHERE Gpa BETWEEN 3.5 AND 4.0;

--8.    Find students who graduated in 2022 (if Graduation_Date existed)
SELECT * 
FROM Student_DB
WHERE EXTRACT(YEAR FROM Graduation_Date) = 2022;

--9.    List all students without email addresses
SELECT * 
FROM Student_DB
WHERE Email IS NULL OR Email = '';

--10.    List all freshmen students living in dorms
SELECT * 
FROM Student_DB
WHERE Academic_Level = 'Freshman' AND Housing_Status = 'Dorm';

--11.    Find the student with the highest GPA
SELECT * 
FROM Student_DB
WHERE Gpa = (SELECT MAX(Gpa) FROM Student_DB);

--12.    Find the student with the lowest GPA
SELECT * 
FROM Student_DB
WHERE Gpa = (SELECT MIN(Gpa) FROM Student_DB);

--13.    Count the number of male and female students
SELECT 
    GENDER,
    COUNT(*) AS Gender_Count
FROM Student_DB
GROUP BY GENDER;

--14.    Find students who are in their 4th semester
SELECT * 
FROM Student_DB
WHERE Current_Semester = 4;

--15.    Retrieve students whose first name starts with "J"
SELECT * 
FROM Student_DB
WHERE First_Name LIKE 'J%';

--16.    List students whose first name has more than 5 characters
SELECT * 
FROM Student_DB
WHERE LENGTH(First_Name) > 5;

--17.    Find all students from Kenya
SELECT * 
FROM Student_DB
WHERE Nationality = 'Kenya';

--18.    Report of average GPA by gender
SELECT 
    GENDER, 
    AVG(Gpa) AS Average_GPA
FROM Student_DB
GROUP BY GENDER;

--19.    Find students who are Juniors and live Off-Campus
SELECT * 
FROM Student_DB
WHERE Academic_Level = 'Junior' AND Housing_Status = 'Off-Campus';

--20.    Retrieve the top 3 students by GPA
SELECT * 
FROM (
    SELECT * 
    FROM Student_DB 
    ORDER BY Gpa DESC
)
WHERE ROWNUM <= 3;

--21.    Count students by ethnicity
SELECT Ethnicity, COUNT(*) AS Student_Count
FROM Student_DB
GROUP BY Ethnicity;

--Using Aggregation Functions
--22.    Get the average GPA of all students.
SELECT AVG(Gpa)
FROM Student_DB;

--23.    Select the unique values for the Housing_Status column.
SELECT unique(Housing_Status)
FROM Student_DB;

--24.    Count the number of female students in the database.
SELECT COUNT(*) AS GENDER_COUNT
FROM Student_DB
WHERE GENDER = 'Female';

--25.    Find the student with the highest GPA.
SELECT MAX(Gpa)
FROM Student_DB;

--26.    List all students who enrolled after March 30, 2021.
SELECT *
FROM Student_DB
WHERE ENROLLMENT_DATE > '2021\03\30';

--Group By and Sorting
--27.    Group students by Academic_Level and count how many are in each level.
SELECT 
ACADEMIC_LEVEL,
COUNT(ACADEMIC_LEVEL) 
FROM Student_DB
GROUP BY ACADEMIC_LEVEL 
ORDER BY ACADEMIC_LEVEL ASC;

SELECT ACADEMIC_LEVEL, COUNT(*) AS Student_Count
FROM Student_DB
GROUP BY ACADEMIC_LEVEL;

--28.    Find students who have a GPA above 3.0 and are majoring in "Nursing Science."
SELECT * FROM Student_DB
WHERE Gpa > 3.0 AND MAJOR = 'Nursing Science';

--29.    List all students along with their respective Nationality, and filter out students without a nationality.
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

--30.    Create a view to show students who are about to graduate in the next semester.
SELECT *
FROM Student_DB
WHERE CURRENT_SEMESTER = 8

--31.    Write a query to find students who have not declared a Secondary_Language
SELECT * FROM Student_DB
WHERE SECONDARY_LANGUAGE IS NULL OR SECONDARY_LANGUAGE = '';

--Using Subqueries
--32.    Use a subquery to find students whose GPAs are above the average GPA of the database.
SELECT *
FROM Student_DB
WHERE GPA > (SELECT AVG(GPA) FROM Student_DB)
ORDER BY Gpa ASC; -- to double check as the avg Gpa is 2.43

-- Using a Common Table Expression (CTE) to categorize students based on their GPA
--33.    Implement a CTE to categorize students based on their GPA into "Low," "Medium," and "High."
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

--Updating Data with Conditional Logic
--34.    Write a query that updates the Housing_Status for students based on their Academic_Level.
UPDATE Student_DB
SET Housing_Status = CASE
    WHEN ACADEMIC_LEVEL = 'Freshman' THEN 'Dorm'
    WHEN ACADEMIC_LEVEL = 'Sophomore' THEN 'Dorm'
    WHEN ACADEMIC_LEVEL = 'Junior' THEN 'Apartment'
    ELSE 'Off-Campus'
END;

--Percentage Calculation
--35.    Find the percentage of students in each Housing_Status category.
SELECT 
HOUSING_STATUS,
(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Student_DB)) AS Percentage_Count
FROM Student_DB
GROUP BY HOUSING_STATUS 
ORDER BY Percentage_Count ASC;

--36. Create a report that summarizes the average GPA by Academic_Level.
SELECT 
    Academic_Level,
    AVG(GPA) AS Average_GPA
FROM 
    Student_DB
GROUP BY 
    Academic_Level;
    
--37.    Retrieve the top 5 students with the highest GPAs and their majors.
SELECT MAX(Gpa) as Gpa_rank
FROM Student_DB
ORDER by Gpa_rank;



