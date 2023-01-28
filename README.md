dbt_shared_artificats

To manage and maintain all the external dbt packages as well as maintain our common core business logic macros and models

1. Models that can be shared across multiple repository, such as calendar model that defines the specific business logics.
2. Macros to be used across the business units. Things like date conversions, seed files to help segment company wide attributes, etc
3. Shared sources (sources.yml files + staging models for those sources)