with diagnosis_codes as (
Select diag_1 as diagnosis_code
from {{ref('stg_hospitals_data')}}
where diag_1 is not null 

union all 

Select diag_2 as diagnosis_code
from {{ref('stg_hospitals_data')}}
where diag_2 is not null  

union all

Select diag_3 as diagnosis_code
from {{ref('stg_hospitals_data')}}
where diag_3 is not null 

),

hub as (
select distinct diagnosis_code,
current_timestamp as load_date,
'stg_hospitals_data' as record_source 
from diagnosis_codes

)

select 
md5(cast (diagnosis_code as VARCHAR)) as h_diagnosis_id,
diagnosis_code,
load_date,
record_source
from hub