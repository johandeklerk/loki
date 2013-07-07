require 'spec_helper'

describe Api::V1::AlbumsController do

  before :each do
    Genre.delete_all
    Artist.delete_all
    Album.delete_all
  end

  describe 'with no albums' do

    it 'creates an album on create' do
      expect {
        make_request :post, '/albums', {:album => (new_album = build(:album)).attributes}
        response.should be_valid_json
        Album.find(response.parsed_body[:id]).title.should eq(new_album.title)
      }.to change(Album, :count).by(1)
    end

    it 'does not show the album' do
      expect {
        make_request :get, "/albums/234234234234"
        response.should be_valid_json
        response.should be_not_found
        expect(response.raw_body).to eq('{}')
      }.to change(Album, :count).by(0)
    end
  end

  describe 'with a test album' do
    context 'a valid album' do
      before :each do
        @album = create(:album)
        @album1 = create(:album_1)
      end

      after :each do
        Album.delete_all
      end

      it 'provides valid JSON on index' do
        expect {
          make_request :get, '/albums'
          response.should be_valid_json
          response.parsed_body.count.should eq(Album.count)
        }.to change(Album, :count).by(0)
      end

      it 'provides a valid JSON album string on show' do
        expect {
          make_request :get, "/albums/#{@album.id}"
          response.should be_valid_json
          expect(response.raw_body).to eq(@album.to_json)
        }.to change(Album, :count).by(0)
      end

      it 'updates an album on update' do
        params = {:album => {:title => Faker::Name.name}}
        expect {
          make_request(:put, "/albums/#{@album.id}", params)
          response.should be_valid_json
          Album.find(response.parsed_body[:id]).title.should eq(params[:album][:title])
        }.to change(Album, :count).by(0)
      end

      it 'deletes an album on delete' do
        expect {
          make_request :delete, "/albums/#{@album1.id}"
        }.to change(Album, :count).by(-1)
      end

      it 'returns the album on a search' do
        expect {
          make_request(:get, '/albums/search', query: {title: @album.title})
          response.should be_valid_json

        }.to change(Album, :count).by(0)
      end
    end

    context 'an invalid album' do

      before :each do
        @album = build(:invalid_album)
      end

      after :each do
        Album.delete_all
      end

      it 'can not create the album' do
        expect {
          make_request :post, '/albums', {:album => (@album.attributes)}
          response.should be_valid_json
          response.should be_server_error
        }.to change(Album, :count).by(0)
      end

      it 'can not update the album' do
        params = {:album => {:title => Faker::Name.name}}
        expect {
          make_request(:put, "/albums/#{@album.id}", params)
          response.should be_valid_json
          response.should be_not_found
        }.to change(Album, :count).by(0)
      end

      it 'can not delete the album' do
        expect {
          make_request :delete, "/albums/#{@album.id}"
          response.should be_not_found
        }.to change(Album, :count).by(0)
      end
    end
  end
end