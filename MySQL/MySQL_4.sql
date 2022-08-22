-- INSERT INTO <table> [column1, column2] VALUES (value1, value2);

USE market_db;
CREATE TABLE testing (toy_id INT, toy_name CHAR(4), age INT);
INSERT INTO testing VALUES (1, 'nael', 25);

INSERT INTO testing(toy_id, toy_name) VALUES (2, 'buzz');

INSERT INTO testing(toy_id, toy_name, age) VALUES (3, 'jessy', 20);

CREATE TABLE testing2(
	toy_id INT AUTO_INCREMENT PRIMARY KEY, 
    toy_name CHAR(4), 
    age INT);
    
INSERT INTO testing2 VALUES (NULL, 'boppip', 25);
INSERT INTO testing2 VALUES (NULL, 'snipping', 22);
INSERT INTO testing2 VALUES (NULL, 'lex', 21);

SELECT LAST_INSERT_ID(); -- AUTO_INCREMENT 를 통해 생성된 ID의 마지막 번호를 확인

ALTER TABLE testing2 AUTO_INCREMENT = 100; -- ALTER TABLE을 통해 ID 시작을 바꿀 수 있음.
INSERT INTO testing2 VALUES (NULL, 'jaenam', 35);


CREATE TABLE testing3(
	toy_id INT AUTO_INCREMENT PRIMARY KEY, 
    toy_name CHAR(10), 
    age INT);

ALTER TABLE testing3 AUTO_INCREMENT = 1000;
SET @@auto_increment_increment=3; -- STEP = 3

INSERT INTO testing3 VALUES (NULL, 'tomas', 20);
INSERT INTO testing3 VALUES (NULL, 'james', 23);
INSERT INTO testing3 VALUES (NULL, 'gorden', 25);
SELECT * FROM testing3;

-- INSERT INTO ~ SELECT 
-- 다른 테이블에 있는 데이터를 한 번에 입력할 때 사용함.
SELECT COUNT(*) FROM world.city;

DESC world.city; -- describe 

SELECT * FROM world.city LIMIT 5;

CREATE TABLE city_popul (city_name CHAR(35), population INT);
INSERT INTO city_popul 
	SELECT Name, population FROM world.city;

SELECT * FROM city_popul;


-- UPDATE 
USE markey_db;
UPDATE city_popul 
	SET city_name = '서울' -- 바꾸고 싶은 값
    WHERE city_name = 'Seoul'; -- 원래 있는 값 '서울' -> 'Seoul'
    
SELECT * FROM city_popul WHERE city_name='서울';
    
UPDATE city_popul 
	SET city_name = '뉴욕', population = 0 
    WHERE city_name = 'New York';
SELECT * FROM city_popul WHERE city_name = '뉴욕';

UPDATE city_popul 
	SET population = population / 10000 ; 
SELECT * FROM city_popul LIMIT 5; 

-- DELETE FROM <table> WHERE <condition>;
DELETE FROM city_popul 	WHERE city_name LIKE 'New%';

DELETE FROM city_popul WHERE city_name LIKE 'New%' LIMIT 5;


