require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'
require 'json'
require_relative './public/feature_1/tests_all'
require_relative './public/feature_1/exams_all'

before do
  headers 'Access-Control-Allow-Origin' => 'http://localhost:4004',
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

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)