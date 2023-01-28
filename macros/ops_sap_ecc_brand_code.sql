{% macro ops_sap_ecc_brand_code(region=none, model=none) -%}

    {%- if region is none and model is none -%}
        {{ exceptions.raise_compiler_error("!!!Error!!! Both model name and region can not be empty") }}
    {% endif %}

    {% if model == 'purchase_order_item_allocation_ecc' %}
        {% if region == 'SAP_ECC_1' %}
            {% set brand_code = "replace(ltrim(replace(ekkn.zzprod,'0',' ')),' ',0)" %}
        {% endif %}
    {% elif model == 'project_activity' %}
        {% set brand_code = 'prps_ZZFBRAND' %}
    {% endif %}

    {{- brand_code -}}

{% endmacro %}