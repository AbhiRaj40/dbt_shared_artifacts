{%- macro generate_delete_query(sources) -%}

    {%- if sources is none -%}

        {{ exceptions.raise_compiler_error("!!!Error!!! sources can not be empty") }}

    {%- endif -%}


    {%- set ns = namespace(query='false',source_tables_region=[],source_tables_non_region=[]) -%}

    {%- set ecc_regions = ['SAP_ECC_LA','SAP_ECC_EU','SAP_ECC_AS','SAP_ECC_FR','SAP_ECC_NA','SAP_ECC_IP','SAP_ECC_IC'] -%}


    {# segregate sources in to two categories - Tables that are available in 7 regions and tables available in single regions #}


    {%- for i in sources -%}

        {%- if 'region' in i -%}

            {%- if i not in ns.source_tables_region -%}

                {%- do ns.source_tables_region.append(i) -%}

            {%- endif -%}

        {%- else -%}

            {%- if i not in ns.source_tables_non_region -%}

                {%- do ns.source_tables_non_region.append(i) -%}

            {%- endif -%}

        {%- endif -%}

    {%- endfor -%}


    {%- set ns.query = 'with ' -%}


    {# create CTE for sources tables to filter out delete records #}


    {%- for i in ns.source_tables_non_region -%}

        {%- set i = i.replace(' ', '') -%}

        {%- set db_table = i.replace("'", "").split('(')[1].split(')')[0].split(',') -%}

        {%- set db_name = db_table[0] -%}

        {%- set table_name = db_table[1] -%}

        {%- set var_val = source(db_name,table_name) | string -%}

        {%- set ns.query = ns.query + db_name + "_" + table_name + " as(select * from " + var_val + " where REC_ACTN_TYPE_CD != 'D'),\n" -%}

    {%- endfor -%}


    {# use loop to generate query for all seven regions #}


    {%- for i in ns.source_tables_region -%}

    {%- for region in ecc_regions -%}

        {%- set i = i.replace(' ', '') -%}

        {%- set db_table = i.replace("'", "").split('(')[1].split(')')[0].split(',') -%}

        {%- set db_name = db_table[0] -%}

        {%- set table_name = db_table[1] -%}

        {%- set var_val = source(region,table_name) | string -%}

        {%- set ns.query = ns.query + region + "_" + table_name + " as(select * from " + var_val + " where REC_ACTN_TYPE_CD != 'D'),\n" -%}

    {%- endfor -%}

    {%- endfor -%}

    {{- ns.query -}}

{%- endmacro -%}