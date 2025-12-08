Diabetes Hospital Analytics Using Data Vault, dbt, and DuckDB
End-to-End Healthcare Analytics Engineering Project

This repository contains an end-to-end analytics engineering project built using:

Data Vault 2.0 (Hubs, Links, Satellites)

dbt Core for transformations, lineage & testing

DuckDB as the analytical engine

Power BI (Part 2) for visualizations

The dataset used is the publicly available Kaggle dataset:
“Diabetes 130-US hospitals for years 1999–2008”.

🧭 Project Architecture
Raw CSV → dbt Staging (Silver) → Data Vault (Gold) → Marts → Power BI Dashboards

Staging Layer

Performed:

Type casting

Standardization of missing values

Column renaming and cleaning

Preparation for Data Vault modeling

Data Vault 2.0 Layer

Includes:

Hubs – business keys

Links – relationships

Satellites – descriptive attributes

This layer ensures:

Auditability

Scalability

Historical tracking

Separation of keys and context

Marts Layer

Analytical models designed to answer key business questions about patient encounters, length of stay, diagnoses, and case complexity.

Business Questions Answered

Which patients have the most encounters and hospital days?

How does length of stay vary by admission type and medical specialty?

How many diagnoses do patients accumulate over time?

Which encounters are the most complex based on diagnoses and length of stay?

Each question is implemented as a dbt model in the marts folder using SQL window functions.

Analytical Models (dbt Marts)
1. Patient Encounter Ranking

Ranks patients by:

number of encounters

total hospital days

Uses:

RANK()

COUNT()

SUM()

File: models/marts/patient_encounter_ranking.sql

2. Hospital Stay Patterns

Computes average LOS by:

admission type

medical specialty

Uses:

AVG() OVER(PARTITION BY …)

File: models/marts/stay_patterns.sql

3. Cumulative Diagnosis Trend

Tracks how diagnoses accumulate over time for each patient.

Uses:

SUM() OVER(PARTITION BY … ORDER BY …)

File: models/marts/diagnosis_cumulative_trend.sql

4. Encounter Complexity

Ranks encounters by:

number of diagnoses

time in hospital

File: models/marts/encounter_complexity.sql

🏗️ Repository Structure
diabetes_hospital_analytics_dv_dbt/
│
├── README.md
│
├── docs/
│   ├── dbt_dag.png
│   
│
├── models/
│   ├── staging/
│   │   └── stg_hospitals_data.sql
│   │
│   ├── vault/
│   │   ├── hubs/
│   │   │   ├── h_patient.sql
│   │   │   ├── h_encounter.sql
│   │   │   └── h_diagnosis.sql
│   │   │
│   │   ├── links/
│   │   │   ├── l_patient_encounter.sql
│   │   │   └── l_encounter_diagnosis.sql
│   │   │
│   │   └── satellites/
│   │       ├── s_patient_details.sql
│   │       ├── s_encounter_details.sql
│   │       └── s_diagnosis.sql
│   │
│   ├── marts/
│   │   ├── diagnosis_trends.sql
│   │   ├── encounter_patterns.sql
│   │   ├── encounters_by_number_of_diagnoses.sql
│   │   └── patient_ranking.sql
│   │
│   └── schema.yml
│
├── sources.yml
│
└── powerbi/ (Part 2)
    ├── dashboard_screenshots/
    └── pbix_notes.md

How to Run the Project Locally
1. Install dbt & DuckDB
pip install dbt-core dbt-duckdb

2. Initialize DuckDB

Place your DuckDB file in:

/duckdb/healthcarebi.duckdb

3. Run dbt
dbt debug
dbt run
dbt test

4. Generate Documentation
dbt docs generate
dbt docs serve