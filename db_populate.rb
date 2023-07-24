# frozen_string_literal: true

require 'csv'
require_relative 'db_setup'

# O módulo CSVIMPORTER importa os dados do arquivo .csv, que possui todos os dados de exames, médicos e pacientes
module CSVIMPORTER
  def self.import_data_from_csv
    csv_data = CSV.read('./data.csv', headers: true, col_sep: ';')

    doctors_map = {}

    csv_data.each do |row|
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
        "INSERT INTO exams (token, type, limits, result, result_date, doctor_id)
        VALUES ($1, $2, $3, $4, $5, $6)",
        [row['token resultado exame'], row['tipo exame'], row['limites tipo exame'], row['resultado tipo exame'],
         row['data exame'], doctor_id]
      )

      exam_id = $connect_pg.exec_params(
        'SELECT id FROM exams WHERE token = $1',
        [token]
      ).first['id']

      cpf = row['cpf']

      existing_patient = $connect_pg.exec_params(
        'SELECT * FROM patients WHERE cpf = $1',
        [cpf]
      ).first

      next if existing_patient

      $connect_pg.exec_params(
        "INSERT INTO patients (cpf, name, email, birthday, address, city, state, exam_id)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
        [row['cpf'], row['nome paciente'], row['email paciente'], row['data nascimento paciente'],
         row['endereço/rua paciente'], row['cidade paciente'], row['estado patiente'], exam_id]
      )

      $connect_pg.exec_params(
        'SELECT id FROM patients WHERE cpf = $1',
        [cpf]
      ).first['id']
    end
  end
end
