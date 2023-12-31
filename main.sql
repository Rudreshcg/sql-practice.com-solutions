
Section1: Easy

Questions 1- 17

1. Show first name, last name, and gender of patients whos gender is 'M'

SELECT first_name, last_name, gender FROM patients
WHERE gender = 'M';

2. Show first name and last name of patients who does not have allergies. (null)

SELECT first_name, last_name FROM patients
WHERE allergies IS NULL

3. Show first name of patients that start with the letter 'C'
SELECT first_name FROM patients
WHERE first_name LIKE 'C%';


4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name, last_name FROM patients
WHERE weight <= 120 AND weight >= 100;

5. Update the patients table for the allergies column. If the patients allergies is null then replace it with 'NKA'

sql
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

6. Show first name and last name concatenated into one column to show their full name.

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

7. Show first name, last name, and the full province name of each patient.

SELECT first_name, last_name, province_name
FROM patients
         JOIN province_names ON patients.province_id = province_names.province_id;

8. Show how many patients have a birth_date with 2010 as the birth year.

SELECT COUNT(patients.birth_date)
FROM patients
WHERE birth_date BETWEEN '2010-01-01' AND '2010-12-30';


9. Show the first_name, last_name, and height of the patient with the greatest height.

SELECT first_name, last_name, MAX(height) AS height
FROM patients
GROUP BY first_name, last_name
ORDER BY height DESC
LIMIT 1;

10. Show all columns for patients who have one of the following patient_ids:
    1,45,534,879,1000


SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);


11. Show the total number of admissions

SELECT COUNT(admissions.patient_id) AS total_number_of_admissions
FROM admissions;

12. Show all the columns from admissions where the patient was admitted and discharged on the same day.

SELECT *
FROM admissions
WHERE admission_date = discharge_date;

13. Show the total number of admissions for patient_id 579.

SELECT patient_id, COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 1
GROUP BY patient_id;

14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

SELECT DISTINCT(city) AS unique_cities
FROM patients
         JOIN province_names ON patients.province_id = province_names.province_id
WHERE province_names.province_id = 'NS';

15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70

SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160
  AND weight > 70;

16. Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null

SELECT first_name, last_name, allergies
FROM patients
WHERE city = 'Hamilton'
  AND allergies IS NOT NULL;

17. Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). Show the
    result order in ascending by city.

SELECT city
FROM patients
WHERE city LIKE 'A%'
   OR city LIKE 'E%'
   OR city LIKE 'I%'
   OR city LIKE 'O%'
   OR city LIKE 'U%'
   OR city LIKE 'a%'
   OR city LIKE 'e%'
   OR city LIKE 'i%'
   OR city LIKE 'o%'
   OR city LIKE 'u%'
ORDER BY city ASC;


 Section2: Medium

Questions 1- 23

1. Show unique birth years from patients and order them by ascending.

SELECT DISTINCT year(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;


2. Show unique first names from the patients table which only occurs once in the list.
   For example, if two or more people are named 'John' in the first_name column then dont include their name in the output list.
   If only 1 person is named 'Leo' then include them in the output.

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name = 'John') = 1;



3. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's____%s';


4. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
   Primary diagnosis is stored in the admissions table.

SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
         JOIN admissions a ON p.patient_id = a.patient_id
WHERE diagnosis = 'Dementia';


5. Display every patients first_name.
   Order the list by the length of each name and then by alphbetically.


SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name;

6. Show the total amount of male patients and the total amount of female patients in the patients table.
   Display the two results in the same row.

SELECT (SELECT COUNT(*) FROM patients WHERE gender = 'M') AS male_count,
       (SELECT COUNT(*) FROM patients WHERE gender = 'F') AS female_count;


7. Show the total amount of male patients and the total amount of female patients in the patients table.
   Display the two results in the same row.


SELECT first_name, last_name, allergies
FROM patients
WHERE allergies = 'Penicillin'
   OR allergies = 'Morphine'
ORDER BY allergies ASC, first_name ASC, last_name ASC;


8. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.


SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(diagnosis = diagnosis) > 1;


9. Show the city and the total number of patients in the city.
   Order from most to least patients and then by city name ascending.


SELECT city, COUNT(*) AS number_of_patients
FROM patients
GROUP BY city
ORDER BY number_of_patients DESC, city ASC;


10. Show first name, last name and role of every person that is either patient or doctor.
    The roles are either "Patient" or "Doctor"


SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;


11. Show all allergies ordered by popularity. Remove NULL values from query.


SELECT allergies, COUNT(*) AS total_diagnosis
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC;


12. Show all patients first_name, last_name, and birth_date who were born in the 1970s decade.
    Sort the list starting from the earliest birth_date.

SELECT first_name,
       last_name,
       birth_date
FROM patients
WHERE year(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;


13. We want to display each patients full name in a single column.
    Their last_name in all upper letters must appear first, then first_name in all lower case letters.
    Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
    EX: SMITH,jane

SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS new_name_format
FROM patients
ORDER BY first_name DESC;

14. Show the province_id(s), sum of height; where the total sum of its patients height is greater than or equal to 7,000.

select province_id, sum(height) as sum_hieght from patients
group by province_id
having sum(height)>=7000;


15. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

SELECT (MAX(weight) - MIN(weight)) AS weight_delta
FROM patients
WHERE last_name = 'Maroni';


16. Show all of the days of the month (1-31) and how many admission_dates occurred on that day.
    Sort by the day with most admissions to least admissions.

SELECT day(admission_date) AS day_number,
       COUNT(patient_id)   AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC;


17. Show all columns for patient_id 542 s most recent admission_date.


SELECT *
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1;


18. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
    - patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
    - attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

SELECT patient_id, attending_doctor_id, diagnosis
FROM admissions
WHERE patient_id % 2 = 1 AND attending_doctor_id IN (1, 5, 19)
   OR (attending_doctor_id LIKE '%2%' AND LENGTH(patient_id) = 3);


19. Show first_name, last_name, and the total number of admissions attended for each doctor.
    Every admission has been attended by a doctor.

SELECT first_name, last_name, COUNT(attending_doctor_id) AS total_admission
FROM admissions
         JOIN doctors ON admissions.attending_doctor_id = doctors.doctor_id
GROUP BY first_name, last_name;


20. For each doctor, display their id, full name, and the first and last admission date they attended.


SELECT d.doctor_id,
       CONCAT(d.first_name, ' ', d.last_name) AS full_name,
       MIN(a.admission_date)                  AS first_admission_date,
       MAX(a.admission_date)                  AS last_admission_date
FROM doctors d
         JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY d.doctor_id, full_name;


21. Display the total amount of patients for each province. Order by descending.

SELECT pro.province_name, COUNT(p.patient_id) AS patient_count
FROM province_names pro
         JOIN patients p ON pro.province_id = p.province_id
GROUP BY pro.province_name
ORDER BY patient_count DESC;


22. For every admission, display the patients full name, their admission diagnosis, and their doctors full name who diagnosed their problem.

select concat(patients.first_name, ' ', patients.last_name),
admissions.diagnosis, concat(doctors.first_name, ' ', doctors.last_name) from patients
join admissions on patients.patient_id=admissions.patient_id
join doctors on admissions.attending_doctor_id=doctors.doctor_id

23. Display the number of duplicate patients based on their first_name and last_name.

SELECT first_name, last_name, COUNT(*) AS number_of_duplicates
FROM patients
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;

24. Display patients full name, height in the unit feet rounded to 1 decimal, weight in the unit pounds rounded to 0
decimals, birth_date, gender non abbreviated.
Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.

SELECT concat(first_name, ' ', last_name) as full_name,
round(height/30.48, 1) as height, round(weight*2.205) as weight,
birth_date,
case gender when 'M' then 'MALE'
when 'F' Then 'FEMALE'
ELSE 'OTHERS'
End as gender
FROM patients


Section3: Hard

---

Questions 1- 10

1. Show all of the patients grouped into weight groups.
   Show the total amount of patients in each weight group.
   Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group,
   etc.

SELECT (weight / 10) * 10 AS weight_group, COUNT(*) AS patients_in_this_weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;


2. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m)
   . Weight is in units kg. Height is in units cm.

SELECT patient_id,
       weight,
       height,
       CASE
           WHEN weight / POWER(height / 100.00, 2) >= 30
               THEN 1
           ELSE 0
           END AS isobese
FROM patients;


3. Show patient_id, first_name, last_name, and attending doctors specialty.
   Show only the patients who has a diagnosis as 'Epilepsy' and the doctors first name is 'Lisa'
   Check patients, admissions, and doctors tables for required information.


SELECT p.patient_id, p.first_name, p.last_name, d.speciality FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';


4. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after
   their first admission. Show the patient_id and temp_password.

   The password must be the following, in order:
    - patient_id
    - the numerical length of patient's last_name
    - year of patient's birth_date


SELECT DISTINCT p.patient_id, CONCAT(a.patient_id, LENGTH(p.last_name), EXTRACT(YEAR FROM p.birth_date)) AS temp_password
FROM patients p
         JOIN admissions a ON p.patient_id = a.patient_id;



5. Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
   Give each patient a 'Yes' if they have insurance, and a 'No' if they dont have insurance. Add up the admission_total cost for each has_insurance
   group.


SELECT CASE WHEN a.patient_id % 2 = 0 THEN 'Yes' ELSE 'No' END AS has_insurance,
       SUM(CASE WHEN a.patient_id % 2 = 0 THEN 10 ELSE 50 END) AS cost_after_insurance
FROM admissions a
GROUP BY has_insurance;

7.  We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
    First_name contains an 'r' after the first two letters.
Identifies their gender as 'F'
Born in February, May, or December
Their weight would be between 60kg and 80kg
Their patient_id is an odd number
They are from the city 'Kingston'

select * from patients
where first_name like "__%r%"
and gender = "F"
and month(birth_date) in (2,5,12)
and weight between 60 and 80
and patient_id%2=1
and city="Kingston"



6. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

SELECT pr.province_name
FROM province_names pr
         JOIN patients p ON pr.province_id = p.province_id
GROUP BY province_name
HAVING SUM(CASE WHEN p.gender = 'M' THEN 1 ELSE 0 END) > SUM(CASE WHEN p.gender = 'F' THEN 1 ELSE 0 END);


7. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:

- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'

select * from patients
where first_name like "__%r%"
and gender = "F"
and month(birth_date) in (2,5,12)
and weight between 60 and 80
and patient_id%2=1
and city="Kingston"


8. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

SELECT CONCAT(ROUND(SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%')
FROM patients;


9. For each day display the total amount of admissions on that day. Display the amount changed from the previous date.

SELECT admission_date,
       COUNT(admission_date)                                                             AS admission_day,
       COUNT(admission_date) - LAG(COUNT(admission_date)) OVER (ORDER BY admission_date) AS admission_count_change
FROM admissions
GROUP BY admission_date;

10. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

select province_name from province_names
ORDER BY
CASE WHEN province_name = 'Ontario' THEN 0 ELSE 1 END,
province_name ASC;

11. We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id,
    doctor_full_name, specialty, year, total_admissions for that year.

SELECT d.doctor_id,
CONCAT(d.first_name,' ', d.last_name) doctor_name,
d.specialty,
year(a.admission_date) selected_year,
count(a.patient_id) total_admission
from doctors d
inner join admissions a on a.attending_doctor_id = d.doctor_id
group by d.doctor_id, year(a.admission_date);