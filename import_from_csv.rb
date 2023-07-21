require 'csv'
require 'pg'

db_config = {
  host: 'postgres-proj',
  user: 'admin',
  password: 'password'
}

$connect_pg = PG.connect(db_config)

$connect_pg.exec("DROP TABLE IF EXISTS exams CASCADE;")
$connect_pg.exec("DROP TABLE IF EXISTS doctors CASCADE;")
$connect_pg.exec("DROP TABLE IF EXISTS patients;")


$connect_pg.exec("CREATE TABLE IF NOT EXISTS doctors (
  id SERIAL PRIMARY KEY,
  crm VARCHAR(20),
  crm_state VARCHAR(2),
  name VARCHAR(80),
  email VARCHAR(100)
)")

$connect_pg.exec(" CREATE TABLE IF NOT EXISTS exams (
  id SERIAL PRIMARY KEY,
  token VARCHAR(6),
  type VARCHAR(30),
  limits VARCHAR(30),
  result INTEGER,
  doctor_id INTEGER REFERENCES doctors(id)
)")

$connect_pg.exec("CREATE TABLE IF NOT EXISTS patients (
  id SERIAL PRIMARY KEY,
  cpf VARCHAR(30) UNIQUE,
  name VARCHAR(100),
  email VARCHAR(100),
  birthday DATE,
  address VARCHAR(300),
  city VARCHAR(100),
  state VARCHAR(30),
  exam_id INTEGER REFERENCES exams(id)
)")

def import_data_from_csv
  csv_data = CSV.read('./data.csv', headers: true, col_sep: ';')

  doctors_map = {}


  csv_data.each do |row|
    cpf = row['cpf']

    token = row['token resultado exame']

    crm = row['crm médico']

    doctor_id = doctors_map[crm]

    unless doctor_id
      result = $connect_pg.exec_params(
        "INSERT INTO doctors (crm, crm_state, name, email)
        VALUES ($1, $2, $3, $4)
        RETURNING id",
        [row['crm médico'], row['crm médico estado'], row['nome médico'], row['email médico']]
      )

      doctor_id = result[0]['id']
      doctors_map[crm] = doctor_id
    end


    $connect_pg.exec_params(
      "INSERT INTO exams (token, type, limits, result, doctor_id)
      VALUES ($1, $2, $3, $4, $5)",
      [row['token resultado exame'], row['tipo exame'], row['limites tipo exame'], row['resultado tipo exame'], doctor_id]
    )

    exam_id = $connect_pg.exec_params(
      "SELECT id FROM exams WHERE token = $1",
    [token]
    ).first['id']


    existing_patient = $connect_pg.exec_params(
      "SELECT * FROM patients WHERE cpf = $1",
      [cpf]
    ).first

    next if existing_patient

    $connect_pg.exec_params(
      "INSERT INTO patients (cpf, name, email, birthday, address, city, state, exam_id)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
      [row['cpf'], row['nome paciente'], row['email paciente'], row['data nascimento paciente'],
       row['endereço/rua paciente'], row['cidade paciente'], row['estado patiente'], exam_id]
    )

    patient_id = $connect_pg.exec_params(
      "SELECT id FROM patients WHERE cpf = $1",
      [cpf]
    ).first['id']


  end
end

import_data_from_csv

$connect_pg.close
