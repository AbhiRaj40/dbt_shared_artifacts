{% macro ops_sap_ecc_brand_code(region=none, model=none) -%}


    {%- if region is none  and model is none -%}

        {{ exceptions.raise_compiler_error("!!!Error!!! Both model name and region can not be empty") }}

    {%- endif -%}


    {% if model == 'purchase_order_item_allocation_ecc' %}

        {% if region == 'SAP_ECC_LA' %}

            {% set brand_code = "replace(ltrim(replace(ekkn.zzprod,'0',' ')),' ',0)" %}

        {% elif region == 'SAP_ECC_EU' %}

            {% set brand_code = "substring(replace(ltrim(replace(ekkn.zzfproduct,'0',' ')),' ',0) ,1,4)" %}

        {% elif region == 'SAP_ECC_AS' %}

            {% set brand_code = 'ekkn.zzprod' %}

        {% elif region == 'SAP_ECC_FR' %}

            {% set brand_code = "trim(' ')" %}

        {% elif region == 'SAP_ECC_NA' %}

            {% set brand_code = "replace(ltrim(replace(ekkn.zz_gbrand,'0',' ')),' ',0)" %}

        {% elif region == 'SAP_ECC_IP' %}

            {% set brand_code = "trim(' ')" %}

        {% elif region == 'SAP_ECC_IC' %}

            {% set brand_code = "replace(ltrim(replace(ekkn.zzfprodt,'0',' ')),' ',0)" %}

        {% endif %}

    {% elif model == 'project_activity' %}

        {% if region in ['SAP_ECC_FR','SAP_ECC_IP'] %}

            {% set brand_code = "trim('')" %}

        {% else %}

            {% set brand_code = 'prps.ZZFBRAND' %}

        {% endif %}

    {% elif model in ['supplier_payment_item_allocation_ecc','invoice_item_allocation_ecc'] %}

         {% set brand_code = "replace(ltrim (replace(bkpf.brand_code,'0',' ')),' ',0)" %}

    {% endif %}


    {{- brand_code -}}

{%- endmacro %}