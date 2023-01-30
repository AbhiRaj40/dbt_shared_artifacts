{% macro ops_sap_ecc_bschl(region=none) -%}


    {%- if region is none -%}

        {{ exceptions.raise_compiler_error("!!!Error!!! region can not be empty") }}

    {%- endif -%}


    {% if region == 'AS' %}

        {% set bschl = ('25','26','28','35','36','38','29') %}

    {% else %}

        {% set bschl = ('25','26','28','35','36','38') %}

    {% endif %}


    {{- bschl -}}

{%- endmacro %}