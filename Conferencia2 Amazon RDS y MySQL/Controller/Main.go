package main

import (
	"database/sql"
	"encoding/csv"
	"fmt"
	"io"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
)

type Controller struct {
	DB  *sql.DB
	err error
}

func NewController() *Controller {
	ctrl := &Controller{}
	ctrl.connect()
	return ctrl
}

func (c *Controller) connect() bool {
	var usuario = "root"
	var pass = "mypass"
	var host = "localhost"
	var port = 3306
	var db_name = "hospital"
	c.DB, c.err = sql.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%d)/%s", usuario, pass, host, port, db_name))
	if c.err != nil {
		return false
	}

	c.err = c.DB.Ping()
	if c.err != nil {
		return false
	}

	c.DB.SetMaxOpenConns(100 * 1024)
	return true
}

func (c *Controller) disconnect() {
	c.DB.Close()
}

func (c *Controller) PostData() {
	files := []string{
		"../csv/Provinces.csv",
		"../csv/Doctors.csv",
		"../csv/Patients.csv",
		"../csv/Admissions.csv",
	}

	insertProvinces := ``
	insertDoctors := ``
	insertPatients := ``
	insertAdmissions := ``

	for i, r := range files {
		file, err := os.Open(r)
		if err != nil {
			log.Fatal(err)
		}
		defer file.Close()

		reader := csv.NewReader(file)
		reader.Comma = ','
		header := true

		for {
			line, err := reader.Read()
			if err == io.EOF {
				break
			}
			if err != nil {
				fmt.Println("\033[96mNo se pudo leer la linea del Provinces.csv\033[0m")
				continue
			}
			if header {
				header = false
				continue
			}
			if i == 0 { // Provinces
				if insertProvinces != "" {
					insertProvinces += ",\n"
				}
				insertProvinces += fmt.Sprintf(`("%s", "%s")`, line[0], line[1])
			} else if i == 1 { // Doctors
				if insertDoctors != "" {
					insertDoctors += ",\n"
				}
				insertDoctors += fmt.Sprintf(`(%s, "%s", "%s", "%s")`, line[0], line[1], line[2], line[3])
			} else if i == 2 { // Patients
				if insertPatients != "" {
					insertPatients += ",\n"
				}
				if line[7] != "NULL" {
					insertPatients += fmt.Sprintf(`(%s, "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", %s)`, line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9])
				} else {
					insertPatients += fmt.Sprintf(`(%s, "%s", "%s", "%s", "%s", "%s", "%s", %s, "%s", %s)`, line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9])
				}
			} else if i == 3 { // Admissions
				if insertAdmissions != "" {
					insertAdmissions += ",\n"
				}
				insertAdmissions += fmt.Sprintf(`(%s, "%s", "%s", "%s", %s)`, line[0], line[1], line[2], line[3], line[4])
			}
		}

		_, err = c.DB.Exec(fmt.Sprintf("INSERT INTO province (id, name) VALUES\n%s", insertProvinces))
		if err != nil {
			fmt.Println(err)
		}
		_, err = c.DB.Exec(fmt.Sprintf("INSERT INTO doctor (id, first_name, last_name, speciality) VALUES\n%s", insertDoctors))
		if err != nil {
			fmt.Println(err)
		}
		_, err = c.DB.Exec(fmt.Sprintf("INSERT INTO patient (id, first_name, last_name, gender, birth_date, city, province_id, allergies, height, weight) VALUES\n%s", insertPatients))
		if err != nil {
			fmt.Println(err)
		}
		_, err = c.DB.Exec(fmt.Sprintf("INSERT INTO admission (patient_id, admission_date, discharge_date, diagnosis, attending_doctor_id) VALUES\n%s", insertAdmissions))
		if err != nil {
			fmt.Println(err)
		}
	}
}

func main() {
	var ctrl = NewController()
	ctrl.PostData()
}
