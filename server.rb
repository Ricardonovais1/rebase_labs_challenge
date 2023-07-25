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

get '/learning' do
  rows = CSV.read("./data.csv", col_sep: ';')

  columns = rows.shift

  rows.map do |row|
    row.each_with_object({}).with_index do |(cell, acc), idx|
      column = columns[idx]
      acc[column] = cell
    end
  end.to_json
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)