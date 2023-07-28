require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'
require 'json'

set :public_folder, File.dirname(__FILE__) + '/public/feature_2'

get '/results' do
  File.open('./public/feature_2/index.html').read
end


Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 4002,
  Host: '0.0.0.0'
)