-- stored function
-- SUM, CAST, CONCAT, CURRENT_DATE 등과 같이 사전에 정의된 함수 외에 내가 정의한 함수를 사용하고 싶을 때 사용한다. 

-- STORED FUNCTION을 사용하기 위해서는 SET GLOBAL을 해주어야 한다.
SET GLOBAL log_bin_trust_function_creators = 1; 

USE market_db;
DROP FUNCTION IF EXISTS sumFunc; 


DELIMITER $$
CREATE FUNCTION sumFunc(number1 INT, number2 INT) -- 입력 매개변수 
	RETURNS INT
BEGIN 
	RETURN number1 + number2;
END $$
DELIMITER ; 
SELECT sumFunc(100, 200) AS '합계';


DROP FUNCTION IF EXISTS calcYearFunc; 
DELIMITER $$
CREATE FUNCTION calcYearFunc(dYear INT)
	RETURNS INT
BEGIN 
	DECLARE runYear INT; 
    SET runYear = YEAR(CURDATE()) - dYear; 
    RETURN runYear ;
END $$
DELIMITER ; 

SELECT calcYearFunc(2000) AS '활동햇수'; 

SELECT calcYearFunc(2007) INTO @debut2007;
SELECT calcYearFunc(2013) INTO @debut2013; 
SELECT @debut2007 - @debut20013 AS '2007과 2013 차이';

SELECT mem_id, mem_name, calcYearFunc(YEAR(debut_date)) AS '활동 햇수'
	FROM member; 
    
-- coursor 
-- 테이블에서 한 행씩 처리하기 위한 방식이다. 
-- 1. 커서 선언, 2. 반복 조건 선언, 3.커서 열기, 4.데이터 가져오기, 5.데이터 처리하기, 6.커서 닫기

USE market_db; 
DROP PROCEDURE IF EXISTS cursor_proc;
DELIMITER $$
CREATE PROCEDURE cursor_proc()
BEGIN 
	DECLARE memNumber INT; 
    DECLARE cnt INT DEFAULT 0; 
    DECLARE totNumber INT DEFAULT 0; 
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; 
    
    DECLARE memberCuror CURSOR FOR -- 커서 선언
		SELECT mem_number FROM member; 
	
    DECLARE CONTINUE HANDLER -- 행의 끝이면 endOfRow 변수에 True를 대입 
		FOR NOT FOUND SET endOfRow = TRUE; 
	
    OPEN memberCuror ; 
    
    cursor_loop: LOOP
		FETCH memberCuror INTO memNumber; 
        
        IF endOfRow THEN 
			LEAVE cursor_loop; 
		END IF ; 
        
        SET cnt = cnt + 1; 
        SET totNumber = totNumber + memNumber; 
	END LOOP cursor_loop;
    
    SELECT (totNumber/cnt) AS '회원의 평균 인원 수'; 
    
    CLOSE memberCuror; 
END $$ 
DELIMITER ; 

CALL cursor_proc();

