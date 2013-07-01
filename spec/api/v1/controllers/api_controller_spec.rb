require 'spec_helper'

describe Api::V1::ApiController do

  before do
    @options = [{}, 'HTTP_ACCEPT' => 'application/vnd.loki+json; version=1', :format => :json]
  end

  describe "GET 'index'" do
    it 'should return a 400 bad request' do
      get '/', *@options
      response.should be_bad_request
    end

    it 'should return valid JSON' do
      get '/', *@options
      response.headers.should have_key('Content-Type')
      expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8')
      parsed_body = JSON.parse(response.body)
      parsed_body.should be_a(Hash)
    end

    it 'should have JSON with an error message' do
      get '/', *@options
      parsed_body = JSON.parse(response.body)
      parsed_body.should have_key('error')
    end
  end
end