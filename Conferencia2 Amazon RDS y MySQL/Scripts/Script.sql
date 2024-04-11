CREATE DATABASE IF NOT EXISTS hospital;

USE hospital;

CREATE TABLE IF NOT EXISTS province(
	id   CHAR(2) PRIMARY KEY,
    name VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS patient(
	id          INTEGER PRIMARY KEY,
	first_name  VARCHAR(64),
	last_name   VARCHAR(64),
	gender      CHAR(1),
	birth_date  DATE,
	city        VARCHAR(64),
    province_id CHAR(2),
	allergies   VARCHAR(64),
	height      INTEGER,
	weight      INTEGER,
    FOREIGN KEY (province_id) REFERENCES province(id)
);

CREATE TABLE IF NOT EXISTS doctor(
	id          INTEGER PRIMARY KEY,
	first_name  VARCHAR(64),
	last_name   VARCHAR(64),
	speciality  VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS admission(
	id                  INTEGER PRIMARY KEY AUTO_INCREMENT,
    patient_id          INTEGER,
	admission_date      DATE,
    discharge_date      Date,
    diagnosis           VARCHAR(255),
    attending_doctor_id INTEGER,
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (attending_doctor_id) REFERENCES doctor(id)
);

-- DROP DATABASE IF EXISTS hospital;