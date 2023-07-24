require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'
require 'json'
require_relative 'helper.rb'

get '/tests' do
  content_type :json
  TestsAll.get_all_tests
end

get '/hello' do
  'Hello world!'
end

get '/joao' do
  "<html>
    <body>
      <h1>Olá João</h1>
    </body>
  </html>"
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)