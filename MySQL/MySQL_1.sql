-- make table 
CREATE TABLE `shop_db`.`product` (
  `product_name` CHAR(4) NOT NULL,
  `cost` INT NOT NULL,
  `make_date` DATE NULL,
  `company` CHAR(5) NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`product_name`));

-- default syntax 
SELECT * FROM `shop_db`.member WHERE member_name = '아이유';


-- INDEX
SELECT * FROM member WHERE member_name = '아이유';
CREATE INDEX idx_member_name ON member(member_name);


-- VIEW
SELECT * FROM member; 
CREATE VIEW member_view AS SELECT * FROM member;
SELECT * FROM member_view;

-- stored procedure
SELECT * FROM member WHERE member_name = '나훈아';
SELECT * FROM product WHERE product_id = '삼각김밥';

DELIMITER //
CREATE PROCEDURE myProc1()
BEGIN
	SELECT * FROM member WHERE member_name = '나훈아';
	SELECT * FROM product WHERE product_id = '삼각김밥';
END // 
DELIMITER ;

CALL myProc();
