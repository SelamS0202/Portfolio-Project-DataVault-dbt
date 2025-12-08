with patient_encounter as (
Select 
 h.patient_nbr,
 count (he.encounter_id) as total_encounters,
 sum(e.time_in_hospital) AS total_hospital_days

from 

{{ref('h_patient')}} as h 
join {{ref('s_patient_details')}} as p 
on h.h_patient_id = p.h_patient_id
join {{ ref('l_patient_encounter') }} AS l 
on h.h_patient_id = l.h_patient_id
join {{ ref('h_encounter') }} AS he 
on l.h_encounter_id = he.h_encounter_id
join {{ ref('s_encounter_details') }} AS e 
on he.h_encounter_id = e.h_encounter_id

group by  h.patient_nbr
)
Select
*,
Rank() over (order by total_encounters desc) as encounter_rank,
Rank() over (order by total_hospital_days desc) as hospital_stay_rank
from patient_encounter