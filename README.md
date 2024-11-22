# SQL-Projects
# Student Database Management with SQL

## Overview
This project demonstrates the creation and management of a **Student Database** using SQL. It includes table design, sample data loading, and structured querying to explore and analyze student demographics, academic performance, and enrollment patterns.

## Tools
- **Database**: Oracle Database  
- **IDE**: TOAD for Oracle  
- **Language**: SQL  

## Features
- **Table Design**: 
  - A structured schema for the `Student_DB` table, containing fields for student demographics, academic progress, and enrollment details.
- **Data Types**:
  - Leveraged `VARCHAR2`, `NUMBER`, `DATE`, and `CHAR` for optimized storage and query performance.
- **Queries**:
  - Filtering students by academic level, nationality, or GPA range.
  - Analyzing graduation timelines and housing preferences.
  - Insights into student retention by semester.

## Repository Structure
- **`scripts/`**:
  - `create_student_db.sql`: Contains the `CREATE TABLE` script for the `Student_DB` table.
  - `sample_data.sql`: SQL script to populate the table with sample student data.
  - `queries.sql`: Queries to analyze student data and derive insights.
- **`data/`**:
  - `sample_students.csv`: Example dataset for testing the database.
  - `data_description.txt`: Explanation of the dataset columns.
- **`images/`**:
  - `example_query_result.png`: Screenshot of query results for demonstration.
