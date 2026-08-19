-- Show unique first names from the patients table which only occurs once in the list.

SELECT
  first_name
FROM patients
GROUP BY first_name
HAVING count(first_name) = 1;

-- ALT

SELECT
  first_name
FROM (
    SELECT first_name,
    COUNT(*) AS frequency
    FROM patients
    GROUP BY first_name
)
WHERE frequency = 1;


-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

SELECT
  patient_id,
  first_name
FROM patients
WHERE
  first_name LIKE "S%s"
  AND LENGTH(first_name) >= 6;


-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

SELECT
  p.patient_id,
  p.first_name,
  p.last_name
FROM patients p
  JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = "Dementia";


-- Display every patient's first_name. Order the list by the length of each name and then by alphabetically.

SELECT first_name
FROM patients
ORDER BY
  LENGTH(first_name),
  first_name ASC;



-- Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row

select
  SUM(case WHEN gender = 'F' THEN 1 ELSE 0 END) as female_count,
  SUM(case WHEN gender = 'M' THEN 1 ELSE 0 END) as male_count
FROM patients



-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

SELECT
  first_name,
  last_name,
  allergies
FROM patients
WHERE allergies = 'Penicillin' OR allergies = 'Morphine'
ORDER BY allergies,first_name,last_name ASC;



-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT
  patient_id,
  diagnosis
FROM admissions
group by patient_id,diagnosis
having count(*) > 1;


-- Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

SELECT
	city,
    COUNT(*) AS total_patient
FROM patients
GROUP BY city
ORDER BY COUNT(*) DESC, city;


-- Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"

