SELECT * from province;
SELECT * from doctor;
SELECT * from patient;
select * from admission;

SELECT * FROM patient WHERE allergies IS NOT NULL;

SELECT first_name, gender, weight FROM (
	SELECT * FROM patient WHERE allergies IS NOT NULL
) t WHERE gender = 'M' AND weight < 80;

SELECT * FROM (
	SELECT first_name, gender, weight, height FROM (
		SELECT * FROM patient WHERE allergies IS NOT NULL
	) t WHERE gender = 'M' AND weight < 80
) s WHERE height > 150;

SELECT * from province;
SELECT * from patient;

SELECT id, first_name, province_id
FROM patient;

SELECT p.id, p.first_name, m.name
FROM patient p
JOIN province m ON p.province_id = m.id;

select * from admission;

SELECT p.first_name, p.last_name, a.diagnosis, d.first_name, d.last_name
FROM admission a
JOIN patient p ON a.patient_id = p.id
JOIN doctor d ON a.attending_doctor_id = d.id;

SELECT CONCAT(p.first_name, " ", p.last_name), a.diagnosis, CONCAT(d.first_name, " ", d.last_name)
FROM admission a
JOIN patient p ON a.patient_id = p.id
JOIN doctor d ON a.attending_doctor_id = d.id;

SELECT CONCAT(p.first_name, " ", p.last_name) AS Paciente, a.diagnosis AS Diagnostico, CONCAT(d.first_name, " ", d.last_name) AS Medico
FROM admission a
JOIN patient p ON a.patient_id = p.id
JOIN doctor d ON a.attending_doctor_id = d.id;

SELECT * FROM (
	SELECT CONCAT(p.first_name, " ", p.last_name) AS Paciente, a.diagnosis AS Diagnostico, CONCAT(d.first_name, " ", d.last_name) AS Medico
	FROM admission a
	JOIN patient p ON a.patient_id = p.id
	JOIN doctor d ON a.attending_doctor_id = d.id
) t WHERE Paciente = 'Daniel Nelson';