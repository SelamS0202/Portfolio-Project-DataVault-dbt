with diagnosis_codes_number_diagnosis as (

    select 
        diag_1 as diagnosis_code,
        number_diagnoses,
        'stg_hospitals_data' as record_source
    from {{ ref('stg_hospitals_data') }}
    where diag_1 is not null

    union all

    select 
        diag_2 as diagnosis_code,
        number_diagnoses,
        'stg_hospitals_data' as record_source
    from {{ ref('stg_hospitals_data') }}
    where diag_2 is not null

    union all

    select 
        diag_3 as diagnosis_code,
        number_diagnoses,
        'stg_hospitals_data' as record_source
    from {{ ref('stg_hospitals_data') }}
    where diag_3 is not null
)

select  
    md5(cast(diagnosis_code as varchar)) as h_diagnosis_id,
    number_diagnoses,
    current_timestamp as load_date,
    'stg_hospitals_data' as record_source
from diagnosis_codes_number_diagnosis
