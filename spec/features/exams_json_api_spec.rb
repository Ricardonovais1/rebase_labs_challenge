# frozen_string_literal: true

require 'spec_helper'
require 'sinatra'
require 'rspec'
require 'rack/test'
require_relative '../../public/feature_1/db_populate'
require_relative '../../server_1'
require_relative 'reset_database'

ENV['RACK_ENV'] = 'test'

RSpec.describe "API", type: :request do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context 'Exams' do
    it 'when database is empty' do
      DbPopulate.db_populate_from_csv('./spec/support/data_test_empty.csv')
      get '/exams'

      expect(JSON.parse(last_response.body)).to eq([])
      expect(last_response).to be_ok
    end

    it 'when there is data' do
      DbPopulate.db_populate_from_csv('./spec/support/data_test.csv')

      get '/exams'

      expect(last_response.content_type).to eq 'application/json'
      expect(last_response).to be_ok

      json_response = JSON.parse(last_response.body)
      expect(json_response).to be_an(Array)

      expect(json_response.length).to eq(3)
      expect(json_response[0]['cpf']).to eq('048.973.170-88')
      expect(json_response[1]['cpf']).to eq('048.108.026-04')
      expect(json_response[2]['cpf']).to eq('066.126.400-90')

      ResetDatabase.reset
    end
  end

  context 'Tests' do
    it 'when database is empty' do
      DbPopulate.db_populate_from_csv('./spec/support/data_test_empty.csv')
      get '/tests'

      expect(last_response.status).to eq 200
      expect(last_response.body).to eq("[]")
      json_response = JSON.parse(last_response.body)
    end

    it 'when there is data' do
      DbPopulate.db_populate_from_csv('./spec/support/data_test.csv')

      get '/tests'


      expect(last_response.content_type).to eq 'application/json'
      expect(last_response).to be_ok

      json_response = JSON.parse(last_response.body)
      expect(json_response).to be_an(Array)

      expect(json_response.length).to eq(39)
      expect(json_response[0]['cpf']).to eq('048.973.170-88')
      expect(json_response[15]['cpf']).to eq('048.108.026-04')
      expect(json_response[27]['cpf']).to eq('066.126.400-90')

      ResetDatabase.reset
    end
  end
end