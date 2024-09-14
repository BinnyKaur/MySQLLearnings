USE DTF;

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);

insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

SELECT * FROM activity;

-- #1) Find total active users each day 
SELECT event_date, count(DISTINCT user_id) 
FROM activity 
GROUP BY event_date;

-- #2) Find total active users each week
SELECT Week(event_date,0) AS week_no, count(DISTINCT user_id) as no_of_users 
FROM activity
GROUP BY week_no;

-- #3 Date-wise total number of users who made the purchase same day they installed the app 
SELECT user_id, event_date, count(distinct event_name) as no_of_events
FROM activity
GROUP BY user_id, event_date
HAVING no_of_events = 2;

SELECT event_date, count(new_user) as no_of_users 
FROM 
	(
    SELECT user_id, event_date, 
    CASE WHEN COUNT(DISTINCT event_name) = 2
    THEN user_id 
    ELSE NULL 
    END AS new_user
    FROM activity 
GROUP BY user_id, event_date ) a
GROUP BY event_date;

-- #4) Percentage of Paid users in India, USA and any other users should be tagged as others 
WITH country_users AS 
(
    SELECT CASE 
              WHEN country IN ('India', 'USA') THEN country 
              ELSE 'others' 
           END AS new_country, 
           COUNT(DISTINCT user_id) AS user_cnt
    FROM activity 
    WHERE event_name = 'app-purchase'
    GROUP BY new_country
), 
total AS 
(
    SELECT SUM(user_cnt) AS total_users  
    FROM country_users
)
SELECT 
    cu.new_country, 
    cu.user_cnt * 1.0 / t.total_users * 100 AS perc_users
FROM country_users cu, total t;

-- 5# Among all the users who installed the app on a given day, how many did in app purchase on the very next day - day wise result 
WITH prev_data AS 
(
    SELECT *, 
           LAG(event_name, 1) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_event_name, 
           LAG(event_date, 1) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_event_date 
    FROM activity 
)
SELECT event_date, 
       COUNT(DISTINCT CASE 
                         WHEN event_name = 'app-purchase' 
                              AND prev_event_name = 'app-installed' 
                              AND DATEDIFF(event_date, prev_event_date) = 1 
                         THEN user_id 
                         ELSE NULL 
                     END) AS cnt_users
FROM prev_data
GROUP BY event_date
ORDER BY event_date;
