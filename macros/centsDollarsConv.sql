{% macro centsDollarsConv(colName, sig_figs=2) -%}
round( (1.0 * {{ colName }}) / 100, {{ sig_figs }} )
{%- endmacro %}