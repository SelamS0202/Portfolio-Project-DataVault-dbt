SELECT
md5(cast(encounter_id as nvarchar)) as h_encounter_id,
admission_type_id, 
discharge_disposition_id, 
time_in_hospital, 
medical_specialty, 
number_outpatient,
number_inpatient,
CURRENT_TIMESTAMP as load_date,
'stg_hospitals_data' as record_source
from {{ref('stg_hospitals_data')}}