WITH 
payments AS (
    SELECT  *
    FROM    {{ ref('stg_payments')}}
)
, sumPayments AS (
    SELECT  SUM(amountDollars)  AS totalRevenue
    FROM    payments
    WHERE   1=1
     AND    payment_status IN ('success')
)
SELECT  *
FROM    sumPayments