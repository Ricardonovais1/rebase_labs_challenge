require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'

get '/tests' do
  rows = CSV.read("./data.csv", headers: true, col_sep: ';')

  columns = rows.shift

  rows.map do |row|
    row.each_with_object({}).with_index do |(cell, acc), idx|
      column = columns[idx]
      acc[column] = cell
    end
  end.to_json
end

get '/hello' do
  'Hello world!'
end

get '/sample' do
  rows = CSV.read("./sample.csv", headers: true, col_sep: ';')

  rows.to_json
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)