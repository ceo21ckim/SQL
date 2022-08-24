DROP TABLE IF EXISTS naver_db;
CREATE DATABASE naver_db;

USE naver_db;
DROP TABLE IF EXISTS member;
CREATE TABLE member(
mem_id CHAR(8) NOT NULL PRIMARY KEY, 
mem_name VARCHAR(10) NOT NULL, 
mem_number TINYINT NOT NULL, 
addr CHAR(2) NOT NULL, 
phone1 CHAR(3) NULL, 
phone2 CHAR(8) NULL, 
height TINYINT UNSIGNED NULL,
debut_date DATE NULL 
); -- PRIMARY KEY (mem_id)

USE naver_db;
CREATE TABLE buy(
num INT NOT NULL AUTO_INCREMENT, 
mem_id CHAR(8) NOT NULL, 
prod_name CHAR(6) NOT NULL, 
group_name CHAR(4) NULL, 
price INT NOT NULL, 
amount SMALLINT UNSIGNED NOT NULL, 
PRIMARY KEY(num),
FOREIGN KEY(mem_id) REFERENCES member(mem_id)
);


SELECT * FROM naver_db.member;
INSERT INTO member VALUES ('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES ('TWC', '트와이스', 9, '경남', '02', '11111111', 163, '2017.01.01');

-- TABLE constraint 
-- PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT, NULL


USE naver_db; 
DROP TABLE IF EXISTS member; 
CREATE TABLE member(
mem_id CHAR(8) NOT NULL PRIMARY KEY, 
mem_name VARCHAR(10) NOT NULL, 
height TINYINT UNSIGNED NULL
); 


DROP TABLE IF EXISTS member; 
CREATE TABLE member 
( mem_id CHAR(8) NOT NULL, 
  member_name VARCHAR(10) NOT NULL, 
  height TINYINT UNSIGNED NULL, 
  PRIMARY KEY (mem_id) 
  );
  
DROP TABLE IF EXISTS member;

CREATE TABLE member (
mem_id CHAR(8) NOT NULL, 
mem_name VARCHAR(10) NOT NULL, 
height TINYINT UNSIGNED NULL
);
ALTER TABLE member
	ADD CONSTRAINT 
    PRIMARY KEY (mem_id);
    
-- FOREIGN KEY 

DROP TABLE IF EXISTS buy;
CREATE TABLE buy (
num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
mem_id CHAR(8) NOT NULL, 
prod_name CHAR(8) NOT NULL
);

DROP TABLE IF EXISTS buy;
CREATE TABLE buy ( 
num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
mem_id CHAR(8) NOT NULL, 
prod_name CHAR(8) NOT NULL, 
FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

DROP TABLE IF EXISTS buy;
CREATE TABLE buy ( 
num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
mem_id CHAR(8) NOT NULL, 
prod_name CHAR(8) NOT NULL
);
ALTER TABLE buy
	ADD CONSTRAINT 
	FOREIGN KEY (mem_id) REFERENCES member(mem_id);

INSERT INTO member VALUES('BLK', '블랙핑크', 163);
INSERT INTO member VALUES(NULL, 'BLK', '지갑');
INSERT INTO member VALUES(NULL, 'BLK', '맥북');

SELECT M.mem_id, M.mem_name, B.prod_name 
	FROM buy B 
		INNER JOIN member M 
        ON B.mem_id = M.mem_id; 
        
UPDATE member SET mem_id = 'PINK' WHERE mem_id='BLK' ; -- ERROR 


-- ON UPDATE CASCADE, ON DELETE CASCADE 
DROP TABLE IF EXISTS buy;
CREATE TABLE buy ( 
num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
mem_id CHAR(8) NOT NULL, 
prod_name CHAR(8) NOT NULL
);
ALTER TABLE buy
	ADD CONSTRAINT 
	FOREIGN KEY (mem_id) REFERENCES member(mem_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

-- UNIQUE 
-- 기본키와 비슷하지만, NULL이 존재해도 상관없다. 

DROP TABLE IF EXISTS member; 
CREATE TABLE member ( 
mem_id CHAR(8) NOT NULL PRIMARY KEY, 
mem_name VARCHAR(10) NOT NULL, 
height TINYINT UNSIGNED NULL,
email CHAR(30) NULL UNIQUE
);

-- CHECK 
-- 측정 범위의 값만 입력할 수 있도록 하는 것.
 DROP TABLE IF EXISTS member; 
 CREATE TABLE member ( 
 mem_id CHAR(8) NOT NULL PRIMARY KEY, 
 mem_name VARCHAR(10) NOT NULL, 
 height TINYINT SIGNED NULL CHECK (height >= 100),
 phone1 CHAR(3) NULL
);