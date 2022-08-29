-- INDEX 
-- Clustered Index, Secondary Index 

CREATE TABLE member ( 
mem_id		CHAR(8) NOT NULL PRIMARY KEY, -- Clustered Index
mem_name 	VARCHAR(10) NOT NULL, 
mem_number	INT NOT NULL);

USE market_db ; 
CREATE TABLE table1 ( 
	col1	INT PRIMARY KEY, 
    col2	INT, 
    col3	INT);
SHOW INDEX FROM table1; -- PRIMARY == Clustered Index 

CREATE TABLE table2 (
	col1	INT PRIMARY KEY, 
    col2	INT UNIQUE, 
    col3	INT UNIQUE); -- INT UNIQUE == Secondary Index 

SHOW INDEX FROM table2;

USE market_db; 
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member ( 
	mem_id		CHAR(8), 
    mem_name	VARCHAR(10), 
    mem_number	INT, 
    addr		CHAR(2));

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '대구');

ALTER TABLE member
	ADD CONSTRAINT 
    PRIMARY KEY (mem_id);
SELECT * FROM member;

-- Secondary Index 
USE market_db; 
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member ( 
	mem_id		CHAR(8), 
    mem_name	VARCHAR(10), 
    mem_number	INT, 
    addr		CHAR(2));

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '대구');

ALTER TABLE member 
	ADD CONSTRAINT
    UNIQUE (mem_id);
SELECT * FROM member; 

ALTER TABLE member 
	ADD CONSTRAINT
    UNIQUE (mem_name);
SELECT * FROM member; 

INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울');
SELECT * FROM member ;


-- Balanced tree, B-tree
USE market_db; 
DROP TABLE IF EXISTS cluster;
CREATE TABLE cluster ( 
mem_id CHAR(8), 
mem_name VARCHAR(10)
);
INSERT INTO cluster VALUES('TWC', '트와이스');
INSERT INTO cluster VALUES('BLK', '블랙핑크');
INSERT INTO cluster VALUES('WMN', '여자친구');
INSERT INTO cluster VALUES('OMY', '오마이걸');
INSERT INTO cluster VALUES('GRL', '소녀시대');
INSERT INTO cluster VALUES('ITZ', '잇지');
INSERT INTO cluster VALUES('RED', '레드벨벳');
INSERT INTO cluster VALUES('APN', '에이핑크');

ALTER TABLE cluster 
	ADD CONSTRAINT 
    PRIMARY KEY (mem_id); 

SELECT * FROM cluster;

USE market_db; 
DROP TABLE IF EXISTS second;
CREATE TABLE cluster ( 
mem_id CHAR(8), 
mem_name VARCHAR(10)
);

ALTER TABLE second
	ADD CONSTRAINT 
    UNIQUE (mem_id); 

SELECT * FROM second;
-- Clustered Index와 Second Index 둘다 빠르지만, Clustered Index가 조금 더 빠름.


-- CREATE [UNIQUE] INDEX index_name 
-- ON table_name (column_name) [ASC | DESC] 
-- DROP INDEX index_name ON table_name 

SHOW INDEX FROM member;

SHOW TABLE STATUS LIKE 'member';

CREATE INDEX idx_member_addr 
	ON member (addr); 

SHOW INDEX FROM member; 

SHOW TABLE STATUS LIKE 'member';

ANALYZE TABLE member;  -- index 적용하기 

CREATE UNIQUE INDEX idx_member_mem_number
	ON member (mem_number) ; -- error 

CREATE UNIQUE INDEX idx_member_mem_name 
	ON member (mem_name); 
    
SHOW INDEX FROM member; 

INSERT INTO member VALUES('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10'); -- error 

ANALYZE TABLE member ; -- 지금까지 만든 인덱스를 모두 적용 
SHOW INDEX FROM member; 

SELECT * FROM member; 

SELECT mem_id, mem_name, addr FROM member; 
SELECT mem_id, mem_name, addr 
	FROM member 
    WHERE mem_name = '에이핑크'; -- WEHRE절을 사용해야 INDEX를 사용한다.
    
CREATE INDEX idx_member_mem_number 
	ON member (mem_number); 
ANALYZE TABLE member ; 

SELECT mem_name, mem_number 
	FROM member
    WHERE mem_number >= 7;

SELECT mem_name, mem_number 
	FROM member 
    WHERE mem_number >= 1; 

SELECT mem_name, mem_number 
	FROM member 
    WHERE mem_number*2 >= 14;  -- 이때는 Full table Scan을 한다. 해당 열에 아무런 가공을 하지 않아야 함.
    
SELECT mem_name, mem_nuber 
	FROM member 
    WHERE mem_number >= 14/2; 

SHOW INDEX FROM member;

DROP INDEX idx_member_mem_name ON member;

ALTER TABLE member 
	DROP PRIMARY KEY ; 

SELECT table_name, constraint_name 
	FROM information_schema.referential_constarints
    WHERE constraint_schema = 'markey_db'; 

ALTER TABLE buy 
	DROP FOREIGN KEY buy_ibfk_1; 
ALTER TABLE member 
	DROP PRIMARY KEY; 
    
SELECT mem_id, mem_name, mem_number, addr 
	FROM member 
    WHERE mem_name = '에이핑크';
