{% macro generate_schema_name(custom_schema_name = none, node = none) %}
    {% set unit_test_folder = 'zz_unit_test' %}

    {%- if custom_schema_name is none and node.name is none -%}
        {{ exceptions.raise_compiler_error("!!!Error!!! Both custom schema name and node name can not be empty") }}
    {%- endif -%}

    {%- if custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}
    {%- else -%}
        {%- if '__' in mode.name|string -%}
            {%- set default_schema = '_'.join(node.name.split('__')[0].split('_')[1:]) -%}
            {{ default_schema }}
        {% else %}
            {% if unit_test_folder in node.fqn %}
                {{ default_schema }}
            {% else %}
                {{ exceptions.raise_compiler_error("Invalid model name, should have pattern like this <m or v or i>_<folder/schema>__<entity>.sql. Issue with model - " + '/'.join(node.fqn)) }}
            {% endif %}
        {% endif %}
    {% endif %}

{% endmacro %}