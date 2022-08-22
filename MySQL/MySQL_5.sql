-- INTEGER: TINYINT(1), SMALLINT(2), INT(4), BIGINT(8)

USE market_db;
CREATE TABLE testing4(
	tinyint_col TINYINT, 
    smallint_col SMALLINT, 
    int_col INT, 
    bigint_col BIGINT );
    
INSERT INTO testing4 VALUES (127, 32767, 2147483647, 90000000000000);
INSERT INTO testing4 VALUES (128, 32768, 2147483648, 90000000000000);

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member 
( mem_id	CHAR(8) NOT NULL PRIMARY KEY, 
  mem_name 	VARCHAR(10) NOT NULL, -- 가변형 변수 
  mem_number	TINYINT NOT NULL, 
  addr	CHAR(2) NOT NULL, 
  phone1	CHAR(3), 
  phone2	CHAR(8), 
  height	TINYINT UNSIGNED, -- 원래의 TINYINT는 -128~127 범위이지만, TINYINT UNSIGNED 를 사용하면 0~255 범위로 변환할 수 있다.  
  debut_date DATE ); 
  

CREATE TABLE big_table ( 
    data1 VARCHAR(16383) ); -- CHAR(255), VARCHAR(16383) 까지 제한인데, 자막과 같이 긴 문자를 다루는 경우에는 다른 방식을 사용하여야 한다. 

-- LONGTEXT, LONGBLOB(동영상과 같은 바이너리 데이터를 다룰 때 사용)
CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE movie 
( movie_id			INT, 
  movie_title		VARCHAR(30), 
  movie_director	VARCHAR(20), 
  movie_star		VARCHAR(20), 
  movie_script		LONGTEXT, 
  movie_film		LONGBLOB);


-- FLOAT(4), DOUBLE(8)  
-- DATE(3) [YYYY-MM-DD], TIME(3) [HH:MM:SS], DATETIME(8) [YYYY-MM-DD HH:MM:SS]


-- variable 변수의 경우 임시저장이기 때문에 닫고 나면 사용이 안됨.
SET @myVar1 = 5; 
SET @myVar2 = 4.25 ; 

SELECT @myVar1 ; 
SELECT @myVar1 + @myVar2;

SET @txt = 'JAPAN'; 
SET @height = 166; 
SELECT @txt, mem_name FROM member WHERE height > @height ;

-- PREPARE EXECUTE
SET @count = 3; 
-- SELECT mem_name, height FROM member ORDER BY height LIMIT @count; LIMIT @count는 이 구문에서 먹히질 않음. 이때 사용하는 것이 바로 PREPARE EXECUTE!

SET @count = 3; 
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?';
EXECUTE mySQL USING @count;

SELECT AVG(price) '평균 가격' FROM buy; 


-- 데이터 형 변환 CAST(), CONVERT()
-- CAST ( <VALUE> AS DATA_TYPE [ (LENGTH) ] ) 
-- CONVERT ( <VALUE>, DATA_TYPE [ (LENGTH) ] )
SELECT CAST(AVG(prive) AS SIGNED) '평균 가격' FROM buy; -- SIGNED 부호가 있는 정수형
SELECT CONVERT(AVG(price), SIGNED) '평균 가격' FROM buy;

SELECT CAST('2022$12$12' AS DATE); 
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR), 'X', CAST(amount AS CHAR), '=' ) '가격x수량', price*amount '구매액' FROM buy;


SELECT '100' + '200'; 
SELECT CONCAT('100', '200') ; 
SELECT CONCAT(100, '200') ; 
SELECT 1 > '2mega' ; 
SELECT 3 > '2MEGA' ; 
SELECT 0 = 'mega2' ; 