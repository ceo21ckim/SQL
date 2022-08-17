-- Comparison among values 
SELECT 
    year
    , q1
    , q2 
    , CASE
        WHEN q1 < q2 THEN '+'
        WHEN q1 = q2 THEN ' '
        ELSE '-'
    END AS judge_q1_q2 

    , q2 - q1 AS diff_q2_q1 
    , SIGN(q2 - q1) AS sign_q2_q1 

FROM 
    quarterly_sales

ORDER BY
    year 
;

SELECT 
    year
    -- Q1~Q4 최대 매출 구하기
    , greatest(q1, q2, q3, q4) AS greatest_sales
    -- Q1~Q4 최소 매출 구하기
    , least(q1, q2, q3, q4) AS least_sales 
FROM
    quarterly_sales
ORDER BY 
    year 
;


-- average 
SELECT 
    year
    , (q1 + q2 + q3 + q4) / 4 AS average 
FROM 
    quarterly_sales
ORDER BY 
    year 
; 

SELECT 
    year 
    , (COALESCE(q1, 0) + COALESCE(q2, 0) + COALESCE(q3, 0) + COALESCE(q4, 0)) / 4
    AS average 

FROM 
    quarterly_sales
ORDER BY 
    year 
;

SELECT 
    year
    , (COALESCE(q1, 0) + COALESCE(q2, 0) + COALESCE(q3, 0) + COALESCE(q4, 0))
    / SIGN(COALESCE(q1, 0)) + SIGN(COALESCE(q2, 0)) + SIGN(COALESCE(q3, 0)) + SIGN(COALESCE(q4, 0))
    AS average 
FROM
    quarterly_sales
ORDER BY 
    year 
;


----------
SELECT 
    dt
, ad_id 

    , 100.0 * clicks / impressions AS ctr_as_percent 
FROM 
    advertising_stats 
WHERE
    dt = '2017-04-01'
ORDER BY
    dt, ad_id 
; 



SELECT 
    dt
    , ad_id 
    , CASE 
        WHEN impressions > 0 THEN 100.0 * clicks / impression 
        END AS ctr_as_percent_case 
    , 100.0 * clicks / NULLIF(impression, 0) AS ctr_as_percent_by_null
FROM 
    advertising_stats
ORDER BY 
    dt, ad_id 
;


-- calculate distance between A and B 
SELECT 
    abs(x1 - x2) as abs 
    , sqrt(power(x1-x2, 2)) AS rms 
FROM 
    location_1d 
;

--- point 
SELECT
    sqrt(power(x1 - x2, 2) + power(y1 - y2, 2)) AS dist 
    , point(x1, y2) <-> point(x2, y2) AS dist 
FROM location_2d 
;

-- 시간/날짜에 사칙연산 적용하기 
SELECT
    user_id 
    , register_stamp::timestamp AS register_stamp 
    , register_stamp::timestamp + '1 hour'::interval AS atfer_1_hour 
    , register_stamp::timestamp - '30 minutes'::interval AS before_30_minutes 

    , register_stamp:::date AS regitser_date 
    , (regitser_stamp::date + '1 day'::interval)::date AS after_1_day 
    , (register_stamp::date - '1 month'::inverval)::date AS before_1_month 
FROM mst_users_with_dates 
;

SELECT 
    user_id 
    , CURRENT_DATE AS today 
    , register_stamp::date AS register_date 
    , CURRENT_DATE - register_stamp::date AS diff_days 
FROM mst_users_with_dates 
;


SELECT
    user_id 
    , CURRENT_DATE AS today 
    , register_stamp::date AS register_date 
    , birth_date::date AS birth_date 
    , EXTARCT(YEAR FROM age(birth_date::date)) AS current_age 
    , EXTARCT(YEAR FROM age(register_stamp::date, birth_date::date)) AS register_age 
FROM mst_users_with_dates 
;

