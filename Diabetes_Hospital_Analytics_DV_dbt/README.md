
# Diabetes Hospital Analytics Using Data Vault 2.0, dbt & DuckDB

## End-to-End Healthcare Analytics Engineering Project

An end-to-end analytics engineering project that transforms hospital encounter data into structured analytical datasets using **Data Vault 2.0, dbt Core, DuckDB, and Power BI**.

The project demonstrates an end-to-end data transformation workflow, from raw healthcare data ingestion and staging to Data Vault modelling, analytical data marts, and business intelligence reporting.

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| SQL | Data transformation and analytical queries |
| dbt Core | Data modelling, transformations, lineage, and testing |
| DuckDB | Analytical database engine |
| Data Vault 2.0 | Enterprise data warehouse modelling |
| Power BI | Data visualisation and reporting |
| GitHub | Version control and project documentation |

## 📊 Dataset

The project uses the publicly available **[Diabetes 130-US Hospitals for Years 1999–2008](https://www.kaggle.com/datasets/brandao/diabetes)** dataset from Kaggle.

The dataset contains hospital encounter records for diabetic patients across 130 US hospitals over a ten-year period.

It provides information on patient demographics, hospital admissions, diagnoses, length of stay, and other encounter-related attributes.

## 🏗️ Project Architecture

The project follows a layered data architecture, transforming raw hospital encounter data into analytical data marts for downstream reporting.

**Data Flow:**

```text
Raw CSV Data
     |
     ▼
Staging Layer (Silver)
     |
     ▼
Data Vault 2.0 Layer (Gold)
     |
     ▼
Analytical Data Marts
     |
     ▼
Power BI Dashboards
```

### 1. Staging Layer

The staging layer prepares and standardises raw hospital encounter data before loading it into the Data Vault.

Key transformations include:

- Data type casting and standardisation.
- Handling and standardisation of missing values.
- Column renaming and data cleaning.
- Preparation of source data for Data Vault modelling.

**Model:** `stg_hospitals_data.sql`

### 2. Data Vault 2.0 Layer

The Data Vault layer organises healthcare data using Hubs, Links, and Satellites to separate business keys, relationships, and descriptive attributes.

**Hubs – Business Entities**

Define the core business entities and their unique business keys.

- `h_patient.sql`
- `h_encounter.sql`
- `h_diagnosis.sql`

**Links – Relationships**

Capture relationships between business entities.

- `l_patient_encounter.sql`
- `l_encounter_diagnosis.sql`

**Satellites – Descriptive Attributes**

Store descriptive attributes and contextual information associated with business entities.

- `s_patient_details.sql`
- `s_encounter_details.sql`
- `s_diagnosis.sql`

The Data Vault approach provides a foundation for:

- Historical data tracking.
- Auditability and traceability.
- Separation of business keys and descriptive attributes.
- Flexible and scalable data integration.

### 3. Analytical Data Marts

The marts layer transforms Data Vault data into business-oriented analytical datasets.

These models use SQL transformations and window functions to answer key healthcare analytics questions.

## 📈 Business Questions & Analytical Models

The analytical layer addresses the following business questions:

- Which patients have the highest number of hospital encounters and total hospital days?
- How does the average length of stay vary by admission type and medical specialty?
- How do diagnoses accumulate over time for individual patients?
- Which hospital encounters are the most complex based on diagnosis counts and length of stay?

### 1. Patient Encounter Ranking

**File:** `models/marts/patient_ranking.sql`

Ranks patients based on their hospital utilisation.

Key metrics:

- Total number of hospital encounters.
- Total hospital days.

SQL techniques:

- `RANK()`
- `COUNT()`
- `SUM()`

### 2. Hospital Stay Patterns

**File:** `models/marts/encounter_patterns.sql`

Analyses average hospital length of stay across different admission types and medical specialties.

SQL techniques:

- `AVG()`
- Window functions.
- `PARTITION BY`.

### 3. Diagnosis Trends

**File:** `models/marts/diagnosis_trends.sql`

Analyses the cumulative number of diagnoses associated with individual patients over time.

SQL techniques:

- `SUM()`
- Window functions.
- `PARTITION BY`.
- `ORDER BY`.

### 4. Encounter Complexity

**File:** `models/marts/encounters_by_number_of_diagnoses.sql`

Evaluates hospital encounter complexity using:

- Number of diagnoses recorded per encounter.
- Length of hospital stay.

The resulting dataset supports the identification and comparison of encounters with higher diagnosis counts and longer hospital stays.

## 📁 Repository Structure

```text
diabetes_hospital_analytics_dv_dbt/
│
├── README.md
│
├── docs/
│   └── dbt_dag.png
│
├── models/
│   │
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
│   ├── schema.yml
│   └── sources.yml
│
└── powerbi/
    ├── dashboard_screenshot/
    └── pbix_notes.md
```

## ⚙️ How to Run the Project Locally

### Prerequisites

- Python 3.9 or later.
- dbt Core.
- dbt-duckdb adapter.
- DuckDB database.

### 1. Clone the Repository

```bash
git clone <your-github-repository-url>

cd diabetes_hospital_analytics_dv_dbt
```

### 2. Install Dependencies

Install dbt Core and the DuckDB adapter:

```bash
pip install dbt-core dbt-duckdb
```

### 3. Configure DuckDB

Place your DuckDB database file at the following location:

```text
duckdb/healthcarebi.duckdb
```

Ensure that the database path matches the configuration in your `profiles.yml` file.

### 4. Configure dbt

Configure your DuckDB connection in the dbt profile (`profiles.yml`) and ensure that the profile name matches the project configuration in `dbt_project.yml`.

### 5. Run dbt Commands

**Validate the connection:**

```bash
dbt debug
```

**Execute data transformations:**

```bash
dbt run
```

**Run data quality tests:**

```bash
dbt test
```

### 6. Generate dbt Documentation

Generate project documentation and the model lineage graph:

```bash
dbt docs generate
```

Launch the documentation locally:

```bash
dbt docs serve
```

The dbt documentation provides an interactive view of model dependencies, lineage, and project metadata.

## 📊 Power BI Dashboard

**Part 2 – Healthcare Analytics Visualisation**

Power BI is used to visualise the curated analytical datasets and provide insights into hospital encounters, diagnosis trends, patient utilisation, and length of stay.

The `powerbi/` directory contains:

- Dashboard screenshots.
- Supporting Power BI documentation.

*Dashboard development and visualisation are documented separately as Part 2 of this project.*

## 🎯 Key Skills Demonstrated

- End-to-end analytics engineering.
- Data Vault 2.0 data modelling.
- dbt-based ELT transformations.
- SQL analytical queries and window functions.
- Data cleaning and standardisation.
- Data quality testing.
- Data lineage and documentation.
- Analytical data mart development.
- Power BI reporting and visualisation.

## 👤 Author

**Selam**

Data Engineer | Data Warehousing | Business Intelligence

- Medium: [Row by Row: BI & Data Engineering]
