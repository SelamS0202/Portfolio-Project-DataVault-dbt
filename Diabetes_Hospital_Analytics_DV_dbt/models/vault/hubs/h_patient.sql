with hub as (
SELECT DISTINCT
patient_nbr,
current_timestamp as load_date,
'stg_hospitals_data' as record_source
from {{ref('stg_hospitals_data')}}
)
SELECT
md5(cast(patient_nbr as varchar)) as h_patient_id,
patient_nbr,
load_date,
record_source
from hub