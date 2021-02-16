SELECT  customer_id
FROM    {{ ref('dim_customer')}}
WHERE   1=1 
 AND    latestOrderDate < firstOrderDate