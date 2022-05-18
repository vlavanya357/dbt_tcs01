{% macro dol_eur() -%}

round( 0.96 * {{colname}}, 2)

{%- endmacro %}