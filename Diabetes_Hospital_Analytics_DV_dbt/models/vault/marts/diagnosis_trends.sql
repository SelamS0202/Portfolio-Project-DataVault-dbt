--cumulative diagnoses per patient
With diag_data as (
    Select
        h.patient_nbr,
        he.encounter_id,
        d.number_diagnoses
    from {{ ref('h_patient') }} AS h
    join {{ ref('s_patient_details') }} as p 
	on h.h_patient_id = p.h_patient_id
    join {{ ref('l_patient_encounter') }} as  l 
	on h.h_patient_id = l.h_patient_id
    join {{ ref('h_encounter') }} as  he 
	on l.h_encounter_id = he.h_encounter_id
    join {{ ref('s_encounter_details') }} as  e 
	on he.h_encounter_id = e.h_encounter_id
    join {{ ref('l_encounter_diagnosis') }} as  le 
	on he.h_encounter_id = le.h_encounter_id
    join {{ ref('s_diagnosis') }} as  d 
	on le.h_diagnosis_id = d.h_diagnosis_id
)
Select
    patient_nbr,
    encounter_id,
    number_diagnoses,
    sum(number_diagnoses)over (partition by patient_nbr order by encounter_id rows between UNBOUNDED PRECEDING and current row) AS cumulative_diagnoses
from diag_data
order by patient_nbr, encounter_id
