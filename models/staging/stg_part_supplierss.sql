with source as (

    select * from {{ source('src', 'partsupps') }}

),

changed as (

    select

        -- ids
        {{ dbt_utils.surrogate_key(
            ['ps_partkey', 
            'ps_suppkey']) }} 
                as part_supplier_id,
        ps_partkey as part_id,
        ps_suppkey as supplier_id,

        -- descriptions
        ps_comment as comment,

        -- amounts
        ps_availqty as available_quantity,
        ps_supplycost as cost
        
    from source

)

select * from changed