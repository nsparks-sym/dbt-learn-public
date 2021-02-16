WITH 

payments AS (
    SELECT  *
    FROM    {{ref('stg_payments')}}
)

, orders AS (
    SELECT  *
    FROM    {{ref('stg_orders')}}
)

, orderPayments AS (
    SELECT  o.order_id       
            , o.customer_id
            , o.order_date  
            , CASE 
                WHEN p.payment_status = 'success' THEN
                    p.amountDollars
                ELSE 0
              END    AS amountDollars
    FROM    orders o   INNER JOIN payments p ON (p.order_id = o.order_id)
)

SELECT  order_id     
        , order_date
        , customer_id
        , SUM(amountDollars)    AS amountDollars
FROM    orderPayments
GROUP BY order_id
        , order_date
        , customer_id