{% macro ops_sap_ecc_bschl(region=none) %}

    {%- if region is none -%}
        {{ exceptions.raise_compiler_error("!!!Error!!! region can not be empty") }}
    {%- endif -%}

    {% if region == '1' %}
        {% set bschl = ('25','26') %}
    {% endif %}

    {{- bschl -}}
{%- endmacro %}