WITH payments AS (
    SELECT  id                                      AS payment_id
            , orderid                               AS order_id
            , paymentmethod                         AS payment_method
            , status                                AS payment_status
            , {{ centsDollarsConv('amount', 2)}}    AS amountDollars    -- Without the single quaotes, jinja would be looking for a variable called amount above
            , created           AS created_date
    --FROM    raw.stripe.payment
    FROM    {{ source('stripe', 'payment')}}
)

SELECT  *
FROM    payments


/*
    id              INTEGER
    orderid         INTEGER
    paymentmethod   VARCHAR {credit_card, coupon, gift_card}
    status          VARCHAR {success, fail}
    amount          INTEGER
    created         DATE
    _batched_at     TIMESTAMP
*/