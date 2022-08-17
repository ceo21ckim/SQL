-- CASE, Regex, split_part, CAST, EXTRACT, CONCAT(||)

-- CASE / mst_users table 
SELECT 
    user_id
    , CASE 
        WHEN register_device = 1 THEN 'desktop'
        WHEN register_device = 2 THEN 'smartphone'
        WHEN register_device = 3 THEN 'application'
        -- when assign default value, use ELSE syntax.
        -- ELSE ''
    END AS device_name -- 추출할 때 나오는 column name
FROM mst_users
;
-- When CASE syntax, WHEN <조건식> THEN <조건을 만족할 때의 값>'


-- Regex / access_log table 
SELECT 
    stamp -- timestamp
    -- referrer의 호스트 이름 부분 추출하기 
    -- 'substring'
, substring(referrer from 'http?://([^/]*)') AS referrer_host
FROM access_log
;


SELECT 
    stamp
, substring(referrer from 'http?://([^/]*') AS referrer_host 
FROM access_log 
;



SELECT 
    stamp 
    , url 
    , substring(url from '//[^/]+([^?#]+)') AS path 
    , substring(url from 'id=([^&]*') AS id 
FROM access_log 
;

-- http://www.example.com/video/detail?id=001
-- http://www.example.com/video#ref 
-- http://www.example.com/book/detail?id=002



-- split_part, split function 
SELECT 
    stamp 
    , url 
    -- 경로를 슬래시로 잘라 배열로 분할하기 
    -- 경로가 반드시 슬래시로 시작하므로 2번째 요소가 마지막 계층
    , split_part(substring(url from '//[^/]+([^?#]+'), '/', 2) AS path1 
    , split_part(substring(url from '//[^/]+([^?#]+'), '/', 3) AS path2 

FROM access_log 
;

-- handle(treat) day and timestamp

SELECT
    -- CURRENT_DATE 상수와 CURRENT_TIMESTAMP 상수 사용하기
    CURRENT_DATE AS dt 
    , CURRENT_TIMESTAMP AS stamp
;

-- output 
--       dt    |    stamp
-- 2017-01-30  | 2017-01-30 18:42:57.584993 


-- Extract Date/Time Data of specified value.
SELECT 
    CAST('2016-01-30' AS date) AS dt
    CAST('2016-01-30 12:00:00' AS timestamp) AS stamp
;

SELECT
    stamp
    , EXTRACT(YEAR FROM stamp) AS year 
    , EXTRACT(MONTH FROM stamp) AS month 
    , EXTRACT(DAY FROM stamp) AS day
    , EXTRACT(HOUR FROM stamp) AS hour
FROM
    (SELECT CAST('2016-01-30 12:00:00' as timestamp) AS stamp) AS t
;



-- COALESCE / treat missing value 
SELECT 
    purchase_id
    , amount 
    , coupon
    , amount - coupon AS discount_amount1
    , amount - COALESCE(coupon, 0) AS discount_amount2 
FROM 
    purchase_log_with_coupon
;

-- CONCAT 
SELECT 
    user_id
    , CONCAT(pref_name, city_name) AS pref_city

FROM 
    mst_user_location
;

-- PostgreSQL의 경우 || 연산자를 사용해도 된다.
SELECT 
    user_id
    , pref_name || city_name AS pref_city

FROM 
    mst_user_location
;


