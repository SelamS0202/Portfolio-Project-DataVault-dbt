select md5(concat(cast(patient_nbr as varchar), cast(encounter_id as varchar))) as l_patient_encounter_id,
md5(cast(patient_nbr as varchar)) as h_patient_id,
md5(cast(encounter_id as varchar)) as h_encounter_id,
current_timestamp as load_date,
'stg_hospitals_data' as record_source
from {{ref('stg_hospitals_data')}}