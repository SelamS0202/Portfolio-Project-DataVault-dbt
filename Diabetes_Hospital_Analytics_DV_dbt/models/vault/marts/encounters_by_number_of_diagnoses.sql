--Encounters by Number of Diagnoses and Hospital Stay
Select
    he.encounter_id,
    h.patient_nbr,
    d.number_diagnoses,
    e.time_in_hospital,
    Rank() Over (Order by e.time_in_hospital desc) as rank_by_stay,
    Rank() Over (Order by d.number_diagnoses desc) as rank_by_diagnoses
From {{ ref('h_encounter') }} AS he
Join {{ ref('s_encounter_details') }} as e
on he.h_encounter_id = e.h_encounter_id
Join {{ ref('l_patient_encounter') }} as lpe
    On e.h_encounter_id = lpe.h_encounter_id
Join {{ ref('h_patient') }} as h
    On lpe.h_patient_id = h.h_patient_id
Join {{ ref('s_patient_details') }} as p
    On h.h_patient_id = p.h_patient_id
Join {{ ref('l_encounter_diagnosis') }} as led
    On e.h_encounter_id = led.h_encounter_id
Join {{ ref('s_diagnosis') }} as d
    On led.h_diagnosis_id = d.h_diagnosis_id
Order by rank_by_stay
