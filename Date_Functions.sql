CREATE DATABASE DTF;
USE DTF;

CREATE TABLE date_functions_demo (
    id INT ,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
 system_date varchar(10)
);

INSERT INTO date_functions_demo (id,start_date, end_date, created_at, updated_at,system_date) VALUES 
(1,'2024-01-01', '2024-12-31', '2024-01-01 10:00:00', '2024-12-31 23:59:59','12/30/2024'),
(2,'2023-06-15', '2024-06-15', '2023-06-15 08:30:00', '2024-06-15 17:45:00','08/15/2024'),
(3,'2022-05-20', '2023-05-20', '2022-05-20 12:15:00', '2023-05-20 18:00:00','10/21/2024');

# 20 Most Important SQL Date Functions: 

# 1)  'NOW()/ current_timestamp()'
SELECT current_timestamp();
SELECT NOW();

# 2) 'Current_date()'
SELECT current_date();

# 3) 'current_time()'
SELECT current_time();

# 4) 'DATE()'
SELECT 
    id, created_at, DATE(created_at), CAST(created_at AS DATE)
FROM
    date_functions_demo;
    
# 5) 'DATE_FORMAT()'
SELECT 
    id,
    start_date,
    DATE_FORMAT(start_date, '%m/%d/%Y') AS new_format
FROM
    date_functions_demo;
    
# 6) 'DATEDIFF()'
SELECT 
    id,
    start_date,
    end_date,
    DATEDIFF(end_date, start_date) AS no_of_days
FROM
    date_functions_demo;
SELECT 
    id,
    start_date,
    end_date,
    end_date - start_date AS no_of_days
FROM
    date_functions_demo;

#7 ) 'DATE_ADD()'
SELECT 
    id,
    start_date,
    DATE_ADD(start_date, INTERVAL 1 DAY) AS start_date_1
FROM
    date_functions_demo;
    
 #Adding one month    
  SELECT 
    id,
    start_date,
    DATE_ADD(start_date, INTERVAL 1 MONTH) AS start_date_1
FROM
    date_functions_demo;  
    
#8) 'DATE_SUB' 
SELECT 
    id,
    start_date,
    DATE_SUB(start_date, INTERVAL 1 DAY) AS start_date_1
FROM
    date_functions_demo;
    
#9) 'DAY'
SELECT id, start_date, DAY(start_date) FROM date_functions_demo;

#10 'MONTH'
SELECT id, start_date, MONTH(start_date) FROM date_functions_demo;

#11 'YEAR' 
SELECT id, start_date, YEAR(start_date) FROM date_functions_demo;

#12 'DAYOFWEEK' -- Monday (1), Tuesday(2),...
SELECT id, start_date, DAYOFWEEK(start_date) FROM date_functions_demo;

#13 'DAYOFYEAR' 
SELECT id, start_date, DAYOFYEAR(start_date) FROM date_functions_demo;

#14 'DAYOFMONTH' 
SELECT id, start_date, DAYOFMONTH(start_date) FROM date_functions_demo;

#15 'DAYNAME' 
SELECT id, start_date, DAYNAME(start_date) FROM date_functions_demo;

#16 'STR_TO_DATE()'
SELECT id, system_date, STR_TO_DATE(system_date, '%m/%d/%Y') as sd FROM date_functions_demo;

#17 'TIMESTAMPDIFF()'
SELECT *, TIMESTAMPDIFF(minute, created_at, updated_at) AS system_diff FROM date_functions_demo; 
SELECT *, TIMESTAMPDIFF(day, created_at, updated_at) AS system_diff FROM date_functions_demo; 

#18 'MONTHNAME()' 
SELECT id, start_date, MONTHNAME(start_date) FROM date_functions_demo;

#19 'LAST_DAY()' 
SELECT id, start_date, last_day(start_date) FROM date_functions_demo;

#20 'EXTRACT()'
SELECT id, start_date, extract(month from start_date) as sd FROM date_functions_demo;
SELECT id, updated_at, extract(hour from updated_at) as sd FROM date_functions_demo;
