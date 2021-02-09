with orders as (
    
    select
        id              AS order_id
        , user_id       AS customer_id
        , order_date
        , status
   -- from raw.jaffle_shop.orders
    FROM    {{ source('jaffle_shop', 'orders')}}
    {{ limitDataInDev('order_date', '4') }}
)

select * from orders
