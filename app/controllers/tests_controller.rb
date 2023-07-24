require_relative '../helper'

class TestsController < Sinatra::Base
  get '/tests' do
    @tests = TestsAll.get_all_tests
    p @tests

    erb :'tests/index', layout: :'layouts/application'
  end
end