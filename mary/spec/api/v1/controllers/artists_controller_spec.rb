require 'spec_helper'

describe Api::V1::ArtistsController do

  describe 'with no artists' do
    before :each do
      Artist.delete_all
    end

    it 'creates an artist on create' do
      expect {
        make_request :post, '/artists', {:artist => (new_artist = FactoryGirl.build(:artist)).attributes}
        response.should be_valid_json
        Artist.find(response.parsed_body[:id]).name.should eq(new_artist.name)
      }.to change(Artist, :count).by(1)
    end

    it 'does not show the artist' do
      expect {
        make_request :get, "/artists/234234234234"
        response.should be_valid_json
        response.should be_not_found
        expect(response.raw_body).to eq('{}')
      }.to change(Artist, :count).by(0)
    end
  end

  describe 'with a test artist' do
    context 'a valid artist' do
      before :each do
        @artist = FactoryGirl.create(:artist)
      end

      after :each do
        Artist.delete_all
      end

      it 'provides valid JSON on index' do
        expect {
          make_request :get, '/artists'
          response.should be_valid_json
          response.parsed_body.count.should eq(Artist.count)
        }.to change(Artist, :count).by(0)
      end

      it 'provides a valid JSON artist string on show' do
        expect {
          make_request :get, "/artists/#{@artist.id}"
          response.should be_valid_json
          expect(response.raw_body).to eq(@artist.to_json)
        }.to change(Artist, :count).by(0)
      end

      it 'updates an artist on update' do
        params = {:artist => {:name => Faker::Name.name}}
        expect {
          make_request(:put, "/artists/#{@artist.id}", params)
          response.should be_valid_json
          Artist.find(response.parsed_body[:id]).name.should eq(params[:artist][:name])
        }.to change(Artist, :count).by(0)
      end

      it 'deletes an artist on delete' do
        expect {
          make_request :delete, "/artists/#{@artist.id}"
        }.to change(Artist, :count).by(-1)
      end
    end

    context 'an invalid artist' do
      before :each do
        @artist = FactoryGirl.build(:invalid_artist)
      end
      after :each do
        Artist.delete_all
      end

      it 'can not create the artist' do
        expect {
          make_request :post, '/artists', {:artist => (@artist.attributes)}
          response.should be_valid_json
          response.should be_server_error
        }.to change(Artist, :count).by(0)
      end

      it 'can not update the artist' do
        params = {:artist => {:name => Faker::Name.name}}
        expect {
          make_request(:put, "/artists/#{@artist.id}", params)
          response.should be_valid_json
          response.should be_not_found
        }.to change(Artist, :count).by(0)
      end

      it 'can not delete the artist' do
        expect {
          make_request :delete, "/artists/#{@artist.id}"
          response.should be_not_found
        }.to change(Artist, :count).by(0)
      end
    end
  end
end