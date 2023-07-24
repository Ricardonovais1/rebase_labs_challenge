# frozen_string_literal: true

require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'rack'
require 'json'
require_relative 'app/helper'
require_relative 'app/controllers/tests_controller'

set :views, File.join(__dir__, 'views')

set :erb, layout: :'layouts/application'

get '/hello' do
  'Hello world!'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
