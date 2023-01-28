Info about customized macros:

generate alias name:

1. source.sql: source.sql overrides he default behavious of sources. When executing with unit_test profile the models read the input from mock_data_models instead of reading from real snowflake database.
mock_data_models will be under models/zz_unit_test/_mock_data_models. Scenario where the table is same in raw and format layer: eg- exchange_rate when refereshing model exchange_rate,
if it is from conform layer it should reference exchange_rate_expected. if it is from raw layer it should pick exchange_rate_input.

2. generate_alias_name.sql: generate_alias_name is default macro that comes with dbt which creates table in snowflake with the same name as model name.
The default behaviour is modified to extract only part of model as table name. Eg: v_supplier__vendor_purchasing_organization_association even though our model has sysntax as shown below, the table gets created with the table name instead of entire model.
The macro splits the model name on " to extract table name. v(v for view)_<table_name>.sql

3. generate_schema_name.sql: generate schema name is default macro that creates models under default schema provided in profiles.yml.
If we provide schema as part of configuration, a schema will be created by combining default schema and schema provided in configuration as shown below <default_schema>_<schema_in_config>.
this default behaviour is modified to create schema with the name provided as a part of configuration. If custome schema is not defined it will consider schema name provided under profile.yml.

4. ops_string_quote_concatenation.sql: Jinja template ignores quotes around string while rendering. If we have variable x like this
{% set x='y' %}, rendering x, {{x}}, only extracts y not 'y'. This macro can be used to render string along with quote.eg:{% set x=stringify('y') %}, {{x}} will return 'y'.

5. ops_sap_ecc_brand_code.sql: The brand code changes based on the region. The brand code is used across multiple models like purchase_order_item_allocation_ecc, invoice_item_allocation_ecc, payment_item_allocation_ecc etc.
the logic changes slightly for each model. This macro takes region and model name as parameters and returns brand code as output.

6. generate_delete_query.sql: macro to generate filter query to exclude 'D' type of records from source tables in a model