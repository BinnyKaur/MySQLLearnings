USE DTF; 

# Creating a Table 
Create table numbers(n int);
Insert into numbers values(1),(2), (3), (4), (5);
insert into numbers values (9);
SELECT * FROM numbers;

#Problem Statement - Write code  to print each number from the table a number of times equal to its value.

#Using Recursive CTE 
WITH RECURSIVE CTE AS (
    -- Base case: Start with the first number n and initialize the counter to 1
    SELECT n, 1 AS num_counter
    FROM numbers

    -- Recursive case: Continue incrementing the counter until it equals n
    UNION ALL

    SELECT n, num_counter + 1
    FROM CTE
    WHERE num_counter + 1 <= n
)
-- Final query: Select everything from the recursive CTE
SELECT *
FROM CTE
ORDER BY n;


-- Using Cross Join 
WITH seq AS (
    -- Generate a dynamic sequence up to the maximum value in the numbers table
    SELECT seq_num
    FROM (
        SELECT 1 AS seq_num UNION ALL
        SELECT 2 UNION ALL
        SELECT 3 UNION ALL
        SELECT 4 UNION ALL
        SELECT 5 UNION ALL
        SELECT 6 UNION ALL
        SELECT 7 UNION ALL
        SELECT 8 UNION ALL
        SELECT 9
    ) AS sequence
)
SELECT n, seq.seq_num
FROM numbers
CROSS JOIN seq
WHERE seq.seq_num <= numbers.n
ORDER BY n, seq.seq_num;