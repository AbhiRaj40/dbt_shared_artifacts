{%- macro source(source_name=none,table_name=none) -%}

  {% set test_profile = 'unit_test' %}

  {%- set table_dup = ['MARA','MARC','LOT','PROJECT','RESULT','SAMPLE','T_PH_ITEM_CODE','T_PH_TEST_ARTICLE','TEST','TIME_ZERO','TIMEPOINT'] -%}

  {%- if source_name is none-%}

        {{ exceptions.raise_compiler_error("!!!Error!!! Source name can not be empty") }}

  {%- endif -%}

  {%- if table_name is none-%}

        {{ exceptions.raise_compiler_error("!!!Error!!! Table name can not be empty") }}

  {%- endif -%}


  {%- if target.name == test_profile -%}

    {%- if table_name in table_dup and source_name == 'SAP_ECC_MDG' -%}

        {{- ref(table_name+'_mdg_input') -}}

    {%- elif table_name in table_dup and source_name == 'PHARMALIMS' -%}

        {{- ref(table_name+'_pharmalims_input') -}}

    {%- else -%}

        {{- ref(table_name+'_input') -}}

    {%- endif -%}

  {%- else -%}

    {% do return(builtins.source(source_name,table_name)) %}

  {%- endif -%}


{%- endmacro -%}