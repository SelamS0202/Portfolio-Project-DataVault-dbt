--Avg hospital stay by admission_type_id and medical_specialty.
Select
    he.encounter_id,
    e.admission_type_id,
    e.medical_specialty,
    e.time_in_hospital,
    Avg(e.time_in_hospital) Over(partition by e.admission_type_id) as avg_stay_by_admission_type,
    Avg(e.time_in_hospital) Over (partition by  e.medical_specialty) as avg_stay_by_specialty
from  {{ ref('h_encounter') }} AS he
join {{ ref('s_encounter_details') }} AS e 
on he.h_encounter_id = e.h_encounter_id
