require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'
require 'json'
require_relative 'tests_all'

get '/tests' do
  content_type :json
  TestsAll.get_all_tests
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)