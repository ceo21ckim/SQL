-- apply IP address type 

SELECT 
    CAST('127.0.0.1' AS inet) < CAST('127.0.0.2' AS inet) AS lt 
    , CAST('127.0.0.1' AS inet) > CAST('192.168.0.1' AS inet) AS gt 
;

SELECT CAST('127.0.0.1' AS inet) << CAST('127.0.0.0/8' AS inet) AS is_contained;

-- Change IP address to integer type 
SELECT 
    ip 
    , CAST(split_part(ip, '.', 1) AS integer) AS ip_part_1 
    , CAST(split_part(ip, '.', 2) AS integer) AS ip_part_2 
    , CAST(split_part(ip, '.', 3) AS integer) AS ip_part_3 
    , CAST(split_part(ip, '.', 4) AS integer) AS ip_part_4

FROM 
    (SELECT CAST('192.168.0.1' AS text) AS ip) AS t
; 


-- COUNT 
SELECT
    COUNT(*) AS total_count 
    , COUNT(DISTINCT user_id) AS user_count 
    , COUNT(DISTINCT product_id) AS product_count 
    , SUM(score) AS sum 
    , AVG(score) AS avg 
    , MAX(score) AS max 
    , MIN(score) AS min 
FROM
    review 
;


-- GROUP BY 

SELECT 
    user_id 
    , COUNT(*) AS total_count 
    , COUNT(DISTINCT product_id) AS product_count 
    , SUM(score) AS sum 
    , AVG(score) AS avg 
    , MAX(score) AS max 
    , MIN(score) AS min 
FROM 
    review 
GROUP BY 
    user_id 
; 

-- OVER and PARTITION BY 
SELECT 
    user_id
    , product_id 
    -- individual reivew score 
    , score 
    -- total average review score 
    , AVG(score) OVER() AS avg_score 
    -- average review score for users 
    , AVG(score) OVER(PARTITION BY user_id) AS user_avg_score 
    -- The differential between individual review scores and user average review score
    , score - AVG(score) OVER(PARTITION BY user_id) AS user_avg_score_diff 
FROM 
    review 
;


-- ORDER BY, RANK, DENSE_RANK
SELECT 
    product_id 
    , score 

    , ROW_NUMBER()  OVER(ORDER BY score DESC) AS row 
    , RANK()    OVER(ORDER BY score DESC) AS rank 
    , DENSE_RANK()  OVER(ORDER BY score DESC) AS dense_rank 
FROM popular_products 
ORDER BY row 
; 

SELECT 
    product_id 
    , score 
    , ROW_NUMBER()  OVER(ORDER BY score DESC) AS row 
    , SUM(score)
        OVER(ORDER BY score DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
    AS cum_score 

    , AVG(score)
        OVER(ORDER BY score DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
    AS local_avg 

    -- extract highest rank product
    , FIRST_VALUE(product_id)
        OVER(ORDER BY score DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    AS first_value 

    -- extract least rank product 
    , LAST_VALUE(product_id)
        OVER(ORDER BY socre DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    AS last_value 

FROM popular_products
ORDER BY row 
;

--- ROWS BETWEEN start AND end
--- start??? end?????? 'CURRENT ROW'(????????? ???), 'n PECEDING'(n??? ???), 'n FOLLOWING'(n??? ???)
--- 'UNBOUNDED PRECEDING'(?????? ??? ??????), 'UNBOUNDED FOLLOWING'(?????? ??? ??????)

SELECT
    product_id 
    , ROW_NUMBER() OVER(ORDER BY score DESC) AS row 
    -- ?????? ??? ???????????? ?????? ??? ???????????? ????????? ???????????? ?????? ID??? ????????????.
    , array_agg(product_id)
    , collect_list(product_id)
    OVER(ORDER BY score DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    AS whole_agg 

    -- ?????? ??? ???????????? ?????? ??????????????? ????????? ???????????? ?????? ID??? ????????????.
    , array_agg(product_id)
    , collect_list(product_id)
    OVER(ORDER BY score DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
    AS cum_agg 

    -- ?????? ?????? ?????? ?????? ????????? ????????? ???????????? ?????? ID??? ????????????.
    , array_agg(product_id)
    , collect_list(product_id)
    OVER(ORDER BY score DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
    AS local_agg
;

-- ??????????????? ?????? n??? ?????? ????????????
SELECT * 
FROM 
    (SELECT 
        category
        , product_id
        , score 
        , ROW_NUMBER()
            OVER(PARTITION BY categry ORDER BY score DESC)
        AS rank 
    FROM popular_products
    ) AS popular_products_with_rank
WHERE rank <=2 
ORDER BY category, rank 
; 


SELECT DISTINCT 
    category 
    , FIRST_VALUE(product_id)
        OVER(PARTITION BY category ORDER BY score DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    AS product_id 
FROM popular_products
;


-- transpose dataframe 
