require 'pg'
require 'json'
require_relative 'db_populate'

module TestsAll
  def self.get_all_tests
    results = $connect_pg.exec("
      SELECT exams.id, exams.token, exams.type, exams.limits, exams.result, exams.result_date,
            patients.cpf AS patient_cpf,
            patients.name AS patient_name,
            patients.email AS patient_email,
            patients.birthday AS patient_birthday,
            patients.address AS patient_address,
            patients.city AS patient_city,
            patients.state AS patient_state,
            doctors.crm AS doctor_crm,
            doctors.crm_state AS doctor_crm_state,
            doctors.name AS doctor_name,
            doctors.email AS doctor_email,
            exams.token AS exam_token

      FROM exams
      INNER JOIN doctors ON exams.doctor_id = doctors.id
      INNER JOIN patients ON exams.id = patients.exam_id
    ")

    tests = results.map do |row|
      {
        id: row['id'],
        cpf: row['patient_cpf'],
        'nome paciente': row['patient_name'],
        'email paciente': row['patient_email'],
        'data nascimento paciente': row['patient_birthday'],
        'endereço/rua paciente': row['patient_address'],
        'cidade paciente': row['patient_city'],
        'estado paciente': row['patient_state'],
        'crm médico': row['doctor_crm'],
        'nome médico': row['doctor_name'],
        'email médico': row['doctor_email'],
        'token resultado exame': row['exam_token'],
        'data exame': row['result_date'],
        'tipo exame': row['type'],
        'limites tipo exame': row['limits'],
        'resultado': row['result']
      }
    end

    tests.to_json
  end
end
