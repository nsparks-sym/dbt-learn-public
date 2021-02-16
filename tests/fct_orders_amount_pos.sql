SELECT  order_id
        , SUM(amountDollars) AS totalAmount
FROM    {{ ref('fct_orders')}}
WHERE   1=1
GROUP BY order_id
HAVING NOT(totalAmount >= 0)