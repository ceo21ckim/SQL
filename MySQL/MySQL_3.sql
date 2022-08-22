-- SELECT <column name> FROM <table name> WHERE <condition> 
-- GROUP BY <column name> HAVING <condition> ORDER BY <column name> LIMIT <number>

-- ORDER BY 
USE market_db;
SELECT mem_id, mem_name, debut_date
	FROM member
    ORDER BY debut_date;
    
SELECT mem_id, mem_name, debut_date 
	FROM member 
    ORDER BY debut_date DESC;
    
SELECT mem_id, mem_name, debut_date, height 
	FROM member 
    WHERE height >= 164
    ORDER BY height DESC;

SELECT mem_id, mem_name, debut_date, height 
	FROM member 
    ORDER BY height DESC, debut_date ASC;

-- LIMIT 
SELECT * FROM member LIMIT 3;

SELECT mem_name, height 
	FROM member 
	ORDER BY height DESC
    LIMIT 3,2; -- 3 ~ 5 

-- DISTINCT drop duplicate
SELECT DISTINCT addr FROM member;


-- GROUP BY 
SELECT mem_id, amount FROM buy ORDER BY mem_id;

SELECT mem_id, SUM(amount) FROM buy GROUP BY mem_id;

SELECT mem_id, SUM(amount) 'total purchase' FROM buy;

SELECT mem_id, SUM(price*amount) 'total purchase price' FROM buy GROUP BY mem_id;

SELECT mem_id, AVG(amount) 'average of purchased item' FROM buy GROUP BY mem_id;

SELECT COUNT(*) FROM member;

SELECT COUNT(phone1) FROM member;

SELECT mem_id, SUM(price*amount) FROM buy GROUP BY mem_id ; 

-- HAVING (GROUP BY 절을 사용하는 경우에는 WHERE 대신 HAVING을 사용하여야 한다. 
SELECT mem_id, SUM(price*amount) FROM buy GROUP BY mem_id HAVING SUM(price*amount) > 1000;

SELECT mem_id, SUM(price*amount)
	FROM buy 
    GROUP BY mem_id 
    HAVING SUM(price*amount) > 1000 
    ORDER BY SUM(price*amount) DESC;






