{% macro string_quote_concatenation(input_value = none) %}
    {%- if input_value is not none -%}
        {{- "'" + input_value + "'" -}}
    {%- else -%}
        {{ exceptions.raise_compiler_error("!!!Error!!! input_value can not be empty, it expects one argument which needs to be") }}
    {%- endif -%}

{%- endmacro -%}