require 'spec_helper'

describe Api::V1::ApiController do

  before do
    @options = [{}, 'HTTP_ACCEPT' => 'application/vnd.loki+json; version=1', :format => :json]
  end

  after do
    response.should be_valid_json
  end

  describe "GET 'index'" do

    it 'should return a 400 bad request' do
      get '/', *@options
      response.should be_bad_request
    end

    it 'should have JSON with an error message' do
      get '/', *@options
      parsed_body = JSON.parse(response.body)
      parsed_body.should have_key('error')
    end
  end
end