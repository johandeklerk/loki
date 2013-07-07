require 'spec_helper'

describe Api::V1::TracksController do

  describe 'with no tracks' do
    before :each do
      Track.delete_all
    end

    it 'creates an track on create' do
      expect {
        make_request :post, '/tracks', {:track => (new_track = FactoryGirl.build(:track)).attributes}
        response.should be_valid_json
        Track.find(response.parsed_body[:id]).title.should eq(new_track.title)
      }.to change(Track, :count).by(1)
    end

    it 'does not show the track' do
      expect {
        make_request :get, "/tracks/234234234234"
        response.should be_valid_json
        response.should be_not_found
        expect(response.raw_body).to eq('{}')
      }.to change(Track, :count).by(0)
    end
  end

  describe 'with a test track' do
    context 'a valid track' do
      before :each do
        @track = FactoryGirl.create(:track)
      end

      after :each do
        Track.delete_all
      end

      it 'provides valid JSON on index' do
        expect {
          make_request :get, '/tracks'
          response.should be_valid_json
          response.parsed_body.count.should eq(Track.count)
        }.to change(Track, :count).by(0)
      end

      it 'provides a valid JSON track string on show' do
        expect {
          make_request :get, "/tracks/#{@track.id}"
          response.should be_valid_json
          expect(response.raw_body).to eq(@track.to_json)
        }.to change(Track, :count).by(0)
      end

      it 'updates an track on update' do
        params = {:track => {:title => Faker::Name.title}}
        expect {
          make_request(:put, "/tracks/#{@track.id}", params)
          response.should be_valid_json
          Track.find(response.parsed_body[:id]).title.should eq(params[:track][:title])
        }.to change(Track, :count).by(0)
      end

      it 'deletes an track on delete' do
        expect {
          make_request :delete, "/tracks/#{@track.id}"
        }.to change(Track, :count).by(-1)
      end
    end

    context 'an invalid track' do
      before :each do
        @track = FactoryGirl.build(:invalid_track)
      end
      after :each do
        Track.delete_all
      end

      it 'can not create the track' do
        expect {
          make_request :post, '/tracks', {:track => (@track.attributes)}
          response.should be_valid_json
          response.should be_server_error
        }.to change(Track, :count).by(0)
      end

      it 'can not update the track' do
        params = {:track => {:title => Faker::Name.title}}
        expect {
          make_request(:put, "/tracks/#{@track.id}", params)
          response.should be_valid_json
          response.should be_not_found
        }.to change(Track, :count).by(0)
      end

      it 'can not delete the track' do
        expect {
          make_request :delete, "/tracks/#{@track.id}"
          response.should be_not_found
        }.to change(Track, :count).by(0)
      end
    end
  end
end