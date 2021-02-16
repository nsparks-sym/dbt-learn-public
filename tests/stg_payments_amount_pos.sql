SELECT  order_id
        , SUM(amountDollars) AS totalAmount
FROM    {{ ref('stg_payments')}}
WHERE   1=1
GROUP BY order_id
HAVING NOT(totalAmount >= 0)