{# If we are in the dev environment, limit the number of days we can query data. #}
{% macro limitDataInDev(colName, dayRange=3) %}
{% if target.name == 'dev' %}
WHERE {{ colName }} >= DATEADD('day', -{{ dayRange }}, current_timestamp)
{% else %}
WHERE 1=1
{% endif %}
{% endmacro %}