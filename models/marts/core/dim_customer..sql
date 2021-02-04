WITH

customers AS (
    select  *
    from    {{ref('stg_customers')}}
)

, orders AS (
    select  *
    from    {{ref('fct_orders')}}
)

, customerOrders AS (
    select  customer_id 
            , MIN(order_date)       AS firstOrderDate
            , MAX(order_date)       AS latestOrderDate
            , COUNT(order_id)       AS numberOrders
            , SUM(amountDollars)    AS lifetimeValue
    FROM    orders 
    GROUP BY customer_id
)

SELECT  c.customer_id
        , c.first_name
        , c.last_name
        , co.firstOrderDate
        , co.latestOrderDate
        , co.numberOrders
        , co.lifetimeValue
FROM    customers c LEFT JOIN customerOrders co ON (c.customer_id = co.customer_id)
ORDER BY c.last_name
        , c.first_name
       