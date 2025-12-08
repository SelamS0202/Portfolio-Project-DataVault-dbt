with unpivoted_diagnoses as (

    -- Unpivot diag_1, diag_2, diag_3
    select
        encounter_id,
        diag_1 as diagnosis_code,
        'stg_hospitals_data' as record_source
    from {{ ref('stg_hospitals_data') }}
    where diag_1 is not null

    union all

    select
        encounter_id,
        diag_2 as diagnosis_code,
        'stg_hospitals_data' as record_source
    from {{ ref('stg_hospitals_data') }}
    where diag_2 is not null

    union all

    select
        encounter_id,
        diag_3 as diagnosis_code,
        'stg_hospitals_data' as record_source
    from {{ ref('stg_hospitals_data') }}
    where diag_3 is not null
),

link as (
    select distinct

        -- link key: hash of the natural key (not hub keys)
        md5(
            concat(
                cast(encounter_id as varchar),
                cast(diagnosis_code as varchar)
            )
        ) as l_encounter_diagnosis_id,

        -- FK to hubs (hash of natural keys)
        md5(cast(encounter_id     as varchar)) as h_encounter_id,
        md5(cast(diagnosis_code   as varchar)) as h_diagnosis_id,

        record_source,
        current_timestamp as load_date

    from unpivoted_diagnoses
)

select * from link
