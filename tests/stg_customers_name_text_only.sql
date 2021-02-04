SELECT  customer_id
        , first_name
        , last_name
FROM    {{ ref('stg_customers')}}
WHERE   1=1
 AND    (first_name LIKE '%[0-9]%'
    OR  last_name LIKE '%[0-9]%')