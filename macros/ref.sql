{% macro ref(model_name=none) %}


  {%- if model_name is none-%}

        {{ exceptions.raise_compiler_error("!!!Error!!! model name can not be empty") }}

  {%- endif -%}


  {% set test_profile = 'unit_test' %}


  {% if target.name == test_profile %}

      {{- builtins.ref(model_name) -}}

  {% else %}

      {% set table_name = model_name.split('__')[1] %}

      {% set schema_name = model_name.split('__')[0][2:] %}

      {% set rel = builtins.ref(model_name) %}

      {% set newrel = rel.replace_path(schema=schema_name) %}

      {% do return(newrel) %}

  {% endif %}


{% endmacro %}