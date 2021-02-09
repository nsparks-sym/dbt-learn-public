WITH 
orders AS (
    SELECT  *
    FROM    {{ ref('stg_orders')}}
)

, daily AS (
    SELECT  order_date
            , COUNT(*)  AS order_num
    FROM    orders
    GROUP BY order_date
)

SELECT  *
FROM    daily