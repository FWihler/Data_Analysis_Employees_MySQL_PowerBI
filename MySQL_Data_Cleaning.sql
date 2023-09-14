-- Create a new database named "projects"
CREATE DATABASE projects;

-- Switch to the "projects" database
USE projects;

-- Select all records from the "hr" table
SELECT * FROM hr;

-- Change the data type of the "id" column to VARCHAR(20)
ALTER TABLE hr
CHANGE COLUMN id emp_id VARCHAR(20) NULL;

-- Describe the structure of the "hr" table
DESCRIBE hr;

-- Select the "birthdate" column from the "hr" table
SELECT birthdate FROM hr;

-- Disable safe updates to allow UPDATE statements without a WHERE clause
SET sql_safe_updates = 0;

-- Update the "birthdate" column to convert date formats
UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Modify the data type of the "birthdate" column to DATE
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Update the "hire_date" column to convert date formats
UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Modify the data type of the "hire_date" column to DATE
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- Update the "termdate" column to convert date formats
UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

-- Modify the data type of the "termdate" column to DATE
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Add a new column "age" to the "hr" table
ALTER TABLE hr ADD COLUMN age INT;

-- Update the "age" column with the age calculated based on birthdate
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

-- Select the minimum and maximum ages from the "hr" table
SELECT 
    min(age) AS youngest,
    max(age) AS oldest
FROM hr;

-- Count the number of records where age is less than 18
SELECT count(*) FROM hr WHERE age < 18;

-- Count the number of records where termdate is in the future
SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

-- Count the number of records where termdate is '0000-00-00'
SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';

-- Select the "location" column from the "hr" table
SELECT location FROM hr;
