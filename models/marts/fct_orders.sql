with 

orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
    where payment_status != 'fail'
),

order_totals as (

    select 

        order_id,
        sum(amount) as order_total

    from payments
    group by 1

),

final as (
    select

        orders.order_id,
        orders.customer_id,
        orders.order_date,
        order_totals.order_total

    from orders
    left join order_totals
        on orders.order_id = order_totals.order_id 

)

select * from final