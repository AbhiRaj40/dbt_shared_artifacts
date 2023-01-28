{% macro generate_alias_name(custom_alias_name=none, node=none) %}
    {% set unit_test_folder = 'zz_unit_test' %}

    {%- if custom_alias_name is none and node.name is none -%}
        {{ exceptions.raise_compiler_error("!!!Error!!! Both custom alias name and node name can not be empty") }}
    {%- endif -%}

    {%- if custom_alias_name is none -%}

        {% if '__' in node.name|string %}
            {% set custom_alias_name = node.name.split('__')[1] %}
            {{ custom_alias_name | trim }}
        {% else %}
            {% if unit_test_folder in node.fqn %}
                {{ node.name | trim }}
            {% else %}
                {{ exceptions.raise_compiler_error("Invalid model name, should have pattern like this <m or v or i>_<folder>__<entity>.sql. Issue with model -  " + '/'.join(node.fqn)) }}
            {% endif %}
        {% endif %}

    {%- else -%}

        {{ custom_alias_name | trim }}

    {%- endif -%}

{% endmacro %}