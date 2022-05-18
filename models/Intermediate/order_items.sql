{{
    config(
        materialized='ephemeral'
    )
}}
with orders as (
    
    select * from {{ ref('stg_orders') }}
),
line_item as (
    select * from {{ ref('stg_line_items') }}
)
select 
    line_item.order_item_id,
    orders.order_id,
    orders.customer_id,
    line_item.part_id,
    line_item.supplier_id,
    orders.order_date,
    orders.status_code as order_status_code,
    
    
    line_item.return_flag,
    
    line_item.line_number,
    line_item.status_code as order_item_status_code,
    line_item.ship_date,
    line_item.commit_date,
    line_item.receipt_date,
    line_item.ship_mode,
    line_item.extended_price,
    line_item.quantity,
    
    -- extended_price is actually the line item total,
    -- so we back out the extended price per item
    (line_item.extended_price/nullif(line_item.quantity, 0)) as base_price,
    line_item.discount_percentage,
    (base_price * (1 - line_item.discount_percentage)) as disc
