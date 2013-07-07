require 'spec_helper'

describe Api::V1::ArtistsController do

  before do
    @options = [{}, 'HTTP_ACCEPT' => 'application/vnd.loki+json; version=1', :format => :json]
  end

  after do
    response.should be_valid_json
  end

  describe "GET 'index'" do
    it 'should be successful' do
      get '/artists', *@options
      response.should be_successful
    end
  end

  describe "GET 'show'" do
    before do
      @artist = FactoryGirl.create(:artist)
    end

    after do
      #@artist.delete
    end

    it 'should be successful' do
      get "/artists/#{@artist.id}"
      response.should be_successful
    end
  end
end