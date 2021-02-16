{%- set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}
-- First dash trims white space before, last trims whitespace after
WITH
payments As (
    SELECT  *
    FROM    {{ ref('stg_payments')}}
),

pivoted AS (
    SELECT  order_id
            {% for i in payment_methods -%}
                , SUM ( CASE WHEN payment_method = '{{ i }}' THEN amountDollars ELSE 0 END ) AS {{ i }}_amt
            {% endfor -%}
            /*
                Or, instead of the smart approach above, can use an IF statement on loop.last
                    -- % signs removed as it turns out Compile will try to compile the jinga in this commented out section even with surrounding comment tags
                {}
                    { if not loop.last }
                        ,   {# this would go after the SUM line #}
                    { endif }
                {}
                {# Also note that Jinja MUST be in lowercase #}
            */
            /*
            , SUM (CASE WHEN payment_method = 'bank_transfer' THEN amountDollars ELSE 0 END)  AS bankTransferAmt
            , SUM (CASE WHEN payment_method = 'coupon' THEN amountDollars ELSE 0 END)         AS couponAmt
            , SUM (CASE WHEN payment_method = 'credit_card' THEN amountDollars ELSE 0 END)    AS creditCardAmt
            , SUM (CASE WHEN payment_method = 'gift_card' THEN amountDollars ELSE 0 END)      AS giftCardAmt
            */
    FROM    payments
    WHERE   1=1
     AND    LOWER(payment_status) = 'success'
    GROUP BY order_id
)

SELECT  *
FROM    pivoted