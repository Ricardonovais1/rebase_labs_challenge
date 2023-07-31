require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'
require 'json'
require 'sidekiq'
require_relative 'public/feature_4/csv_importer'
require_relative './public/feature_1/tests_all'
require_relative './public/feature_1/exams_all'

set :public_folder, File.dirname(__FILE__) + '/public/feature_4'

before do
  headers 'Access-Control-Allow-Origin'  => 'http://localhost:4002',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
end


get '/exams' do
  content_type :json

  ExamsAll.get_all_exams
end

get '/tests' do
  content_type :json
  TestsAll.get_all_tests
end

if ENV['RACK_ENV'] != 'test'
  Rack::Handler::Puma.run(
    Sinatra::Application,
    Port: 4001,
    Host: '0.0.0.0'
  )
end