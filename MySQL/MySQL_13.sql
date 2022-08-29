-- trigger 
-- INSERT UPDATE DELETE 를 할 때 사용됨. -- DML

USE market_db; 
CREATE TABLE IF NOT EXISTS trigger_table (id INT, txt VARCHAR(10));
INSERT INTO trigger_table VALUES(1, '레드벨벳');
INSERT INTO trigger_table VALUES(2, '잇지');
INSERT INTO trigger_table VALUES(3, '블랙핑크');

DROP TRIGGER IF EXISTS myTrigger; 
DELIMITER $$ 
CREATE TRIGGER myTrigger
	AFTER DELETE -- DELECTE trigger 
    ON trigger_table -- attach table 
    FOR EACH ROW  -- 각 행마다 실행
BEGIN 
	SET @msg = '가수 그룹이 삭제됨' ; 
END $$ 
DELIMITER ; 

SET @msg = '';
INSERT INTO trigger_table VALUES(4, '마마무'); 
SELECT @msg; 
UPDATE trigger_table SET txt = '블핑' WHERE id = 3; 

DELETE FROM trigger_table WHERE id = 4;
SELECT @msg ;

USE market_db; 
CREATE TABLE singer (SELECT mem_id, mem_name, mem_number, addr FROM member); 

DROP TABLE IF EXISTS backup_singer; 
CREATE TABLE backup_singer (
mem_id		CHAR(8) NOT NULL, 
mem_name	VARCHAR(10) NOT NULL, 
mem_number	INT NOT NULL, 
addr		CHAR(2) NOT NULL, 
modType		CHAR(2), 
modDate		DATE, 
modUser		VARCHAR(30) 
); 

-- UPDATE trigger 
DROP TRIGGER IF EXISTS singer_updateTrg;
DELIMITER $$ 
CREATE TRIGGER singer_updateTrg 
	AFTER UPDATE 
    ON singer 
    FOR EACH ROW 
BEGIN 
	INSERT INTO backup_singer VALUES(
    OLD.mem_id, 
    OLD.mem_name, 
    OLD.mem_number, 
    OLD.addr, 
    '수정', CURDATE(), CURRENT_USER() ); -- OLD는 삭제, 수정 되기 전 OLD 라는 table에 위치해 있음. 
END $$ 
DELIMITER ; 


-- DELETE trigger
DROP TRIGGER IF EXISTS singer_deleteTrg; 
DELIMITER $$ 
CREATE TRIGGER singer_deleteTrg
	AFTER DELETE 
    ON singer
    FOR EACH ROW 
BEGIN 
	INSERT INTO backup_singer VALUES(
    OLD.mem_id, 
    OLD.mem_name, 
    OLD.mem_numebr, 
    OLD.addr, 
    '삭제', CURDATE(), CURRENT_USER() );
END $$
DELIMITER ;


UPDATE singer SET addr = '영국' WHERE mem_id = 'BLK'; 
DELETE FROM singer WHERE mem_number >= 7; 

SELECT * FROM singer; 
SELECT * FROM backup_singer; 

TRUNCATE TABLE singer; 
