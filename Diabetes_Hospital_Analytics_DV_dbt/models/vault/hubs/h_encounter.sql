with hub as (
SELECT DISTINCT
encounter_id,
current_timestamp as load_date,
'stg_hospitals_data' as record_source
from {{ref('stg_hospitals_data')}}
)
SELECT
md5(cast(encounter_id as varchar)) as h_encounter_id,
encounter_id,
load_date,
record_source
from hub