require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'
require 'json'
require 'sidekiq'
require_relative 'public/feature_4/csv_importer'

set :public_folder, File.dirname(__FILE__) + '/public/feature_4'

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end

get '/upload' do
  File.open('./public/feature_4/index.html').read
end

post '/import_csv' do
  csv_content = params['csvFile'][:tempfile].read.force_encoding("UTF-8")
  CsvImporter.perform_async(csv_content)
end



Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 4004,
  Host: '0.0.0.0'
)