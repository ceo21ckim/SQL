-- VIEW 
USE market_db;
SELECT mem_id, mem_name, addr FROM member;
CREATE VIEW v_member
AS 
	SELECT mem_id, mem_name, addr FROM member;
    
SELECT * FROM v_member;

SELECT mem_name, addr FROM v_member
	WHERE addr IN ('서울', '경기');
    
-- VIEW를 사용하는 이유는 보안에 도움이 된다. VIEW에만 접근이 가능하기 때문에 필요한 정보만 VIEW에 담아두면 된다. 
-- QUERY를 단순하게 만들 수 있다. 
-- VIEW를 사용할 때 별칭을 사용하면 된다. 백틱을 사용해서 묶어줄 수 있다.
USE market_db;
CREATE VIEW v_viewtest1 
AS 
	SELECT B.mem_id `Member ID`, M.mem_name AS `Member Name`, B.prod_name "Product Name", 
		CONCAT(M.phone1, M.phone2) AS "Office Phone" FROM buy B 
        INNER JOIN member M ON B.mem_id = M.mem_id ; 
        
	SELECT DISTINCT `Member ID`, `Member Name` FROM v_viewtest1; 

-- check information of view 
USE market_db; 
CREATE OR REPLACE VIEW v_viewtest2 
AS SELECT mem_id, mem_name, addr FROM member; 
