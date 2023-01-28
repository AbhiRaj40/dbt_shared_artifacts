{%- macro source(source_name = none, table_name = none) -%}
    {% set test_profile = 'unit_test' %}
    {%- set table_dup = ['EKKO','EKPO','MARA','MARC','LFA1','LFB1','BKPF','BSEG'] -%}

    {%- if source_name is none -%}
        {{ exceptions.raise_compiler_error("!!!Error!!! Source name can not be empty") }}
    {%- endif -%}

    {%- if table_name is none -%}
        {{ exceptions.raise_compiler_error("!!!Error!!! Table name can not be empty") }}
    {%- endif -%}

    {%- if target.name == test_profile -%}
        {%- if table_name in table_dup and source_name == 'SAP_MDG' -%}
            {{- ref(table_name + '_mdg_input') -}}
        {%- elif table_name in table_dup and source_name == 'SAP_MDG_1' -%}
            {{- ref(table_name + '_mdg_input') -}}
        {%- else -%}
            {{- ref(table_name + '_input') -}}
        {%- endif -%}
    {%- else -%}
        {% do return(builtins.source(source_name, table_name)) %}
    {%- endif -%}
{%- endmacro -%}