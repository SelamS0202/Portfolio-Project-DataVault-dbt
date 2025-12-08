SELECT
md5(cast(patient_nbr as nvarchar)) as h_patient_id,
gender,
age,
weight,
race,
CURRENT_TIMESTAMP as load_date,
'stg_hospitals_data' as record_source
from {{ref('stg_hospitals_data')}}