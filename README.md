SOLUTIONS

-- Beginner Level (1-3)

-- Retrieve all active patients
-- Write a query to return all patients who are active.

SELECT distinct name FROM public."Patient"
where active = true

-- Find encounters for a specific patient
-- Given a patient_id, retrieve all encounters for that patient, including the status and encounter date.

SELECT distinct patient_id, status, encounter_date 
FROM public."Encounter" 

-- List all observations recorded for a patient
-- Write a query to fetch all observations for a given patient_id, showing the observation type, value, unit, and recorded date.

SELECT distinct patient_id, type, value, unit, recorded_at
FROM public."Observation" 


-- Intermediate Level (4-7)

-- Find the most recent encounter for each patient
-- Retrieve each patient’s most recent encounter (based on encounter_date). Return the patient_id, encounter_date, and status.

SELECT patient_id, encounter_date, status
FROM public."Encounter"
where (patient_id, encounter_date) in (
select patient_id, max(encounter_date) from public."Encounter"
group by patient_id)


-- Find patients who have had encounters with more than one practitioner
-- Write a query to return a list of patient IDs who have had encounters with more than one distinct practitioner.

SELECT patient_id
FROM public."Encounter"
group by patient_id
having count(distinct practitioner_id) > 1

-- Find the top 3 most prescribed medications 
-- Write a query to find the three most commonly prescribed medications from the MedicationRequest table, sorted by the number of prescriptions.

select
medication_name
from public."MedicationRequest"
group by medication_name
order by count(*) desc
limit 3

-- Get practitioners who have never prescribed any medication
-- Write a query to find all practitioners who do not appear in the MedicationRequest table as a prescribing practitioner.

select
distinct id
from public."Practitioner" 
where id not in (select distinct practitioner_id from public."MedicationRequest" )


-- Advanced Level (8-10)

-- Find the average number of encounters per patient (are we including patients that do not exist in the encouter as 0?)
-- Calculate the average number of encounters per patient, rounded to two decimal places.

with t1 as(
select
patient_id, count(*) ct
from public."Encounter" 
group by patient_id
)

select
round(avg(ct),2) avg_encounter
from t1

-- Identify patients who have never had an encounter but have a medication request
-- Write a query to find patients who have a record in the MedicationRequest table but no associated encounters in the Encounter table.

select
distinct p.id
from public."Patient" p inner join public."MedicationRequest" mr on p.id = mr.patient_id
where p.id not in (select distinct patient_id from public."Encounter")


-- Determine patient retention by cohort
-- Write a query to count how many patients had their first encounter in each month (YYYY-MM format) and still had at least one encounter in the following six months.

with t1 as(
select
date_trunc('month', min(encounter_date)) first_month,
patient_id
from public."Encounter"
group by patient_id),

t2 as(
select
e.patient_id, e.encounter_date, to_char(t1.first_month, 'YYYY-MM') first_month
from public."Encounter" e inner join t1 on e.patient_id = t1.patient_id
where e.encounter_date >= t1.first_month + '1 month' and 
e.encounter_date < t1.first_month + '7 months'
order by e.patient_id
)

select distinct
first_month,
count(distinct patient_id) ct
from t2
group by first_month