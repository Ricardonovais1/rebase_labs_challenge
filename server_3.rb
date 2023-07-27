require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'
require 'json'
require 'pg'
require_relative './public/feature_1/exams_all'

set :public_folder, File.dirname(__FILE__) + '/public/feature_3'

get '/api/exams' do
  content_type :json
  ExamsAll.get_all_exams
end

get '/exams' do
  File.open('public/feature_3/index.html').read
end

get '/exams/:token' do
  $connect_pg = PG.connect(host: 'postgres-proj', user: 'admin', password: 'password')
  exam_data = $connect_pg.exec("
    SELECT

        tests.id AS test_id,
        patients.cpf AS patient_cpf,
        patients.name AS patient_name,
        patients.email AS patient_email,
        patients.birthday AS patient_birthday,
        patients.address AS patient_address,
        patients.city AS patient_city,
        patients.state AS patient_state,
        doctors.name AS doctor_name,
        doctors.crm AS doctor_crm,
        doctors.crm_state AS doctor_crm_state,
        doctors.email AS doctor_email,
        exams.token AS exam_token,
        exams.result_date AS exam_result_date,
        tests.test_type AS test_type,
        tests.limits AS test_limits,
        tests.result AS test_result

      FROM exams

      JOIN tests ON exams.token = tests.token_id
      JOIN patients ON exams.patient_id = patients.id
      JOIN doctors ON exams.doctor_id = doctors.id

      WHERE exams.token = $1;", [params[:token]])

  template = File.open('./public/feature_3/show.html').read
  template.gsub('{%exam.token%}', exam_data[0]['exam_token'])
          .gsub('{%exam.result_date%}', exam_data[0]['exam_result_date'])
          .gsub('{%patient.cpf%}', exam_data[0]['patient_cpf'])
          .gsub('{%patient.name%}', exam_data[0]['patient_name'])
          .gsub('{%patient.email%}', exam_data[0]['patient_email'])
          .gsub('{%patient.birthday%}', exam_data[0]['patient_birthday'])
          .gsub('{%patient.address%}', exam_data[0]['patient_address'])
          .gsub('{%patient.city%}', exam_data[0]['patient_city'])
          .gsub('{%patient.state%}', exam_data[0]['patient_state'])
          .gsub('{%doctor.name%}', exam_data[0]['doctor_name'])
          .gsub('{%doctor.crm%}', exam_data[0]['doctor_crm'])
          .gsub('{%doctor.crm_state%}', exam_data[0]['doctor_crm_state'])
          .gsub('{%doctor.email%}', exam_data[0]['doctor_email'])
          .gsub('{%test.type%}', exam_data[0]['test_type'])
          .gsub('{%test.limits%}', exam_data[0]['test_limits'])
          .gsub('{%test.result%}', exam_data[0]['test_result'])
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 4008,
  Host: '0.0.0.0'
)