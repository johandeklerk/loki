require 'spec_helper'

describe Api::V1::GenresController do

  describe 'with no genres' do
    before :each do
      Genre.delete_all
    end

    it 'creates an genre on create' do
      expect {
        make_request :post, '/genres', {:genre => (new_genre = FactoryGirl.build(:genre)).attributes}
        response.should be_valid_json
        Genre.find(response.parsed_body[:id]).name.should eq(new_genre.name)
      }.to change(Genre, :count).by(1)
    end

    it 'does not show the genre' do
      expect {
        make_request :get, "/genres/234234234234"
        response.should be_valid_json
        response.should be_not_found
        expect(response.raw_body).to eq('{}')
      }.to change(Genre, :count).by(0)
    end
  end

  describe 'with a test genre' do
    context 'a valid genre' do
      before :each do
        @genre = FactoryGirl.create(:genre)
      end

      after :each do
        Genre.delete_all
      end

      it 'provides valid JSON on index' do
        expect {
          make_request :get, '/genres'
          response.should be_valid_json
          response.parsed_body.count.should eq(Genre.count)
        }.to change(Genre, :count).by(0)
      end

      it 'provides a valid JSON genre string on show' do
        expect {
          make_request :get, "/genres/#{@genre.id}"
          response.should be_valid_json
          expect(response.raw_body).to eq(@genre.to_json)
        }.to change(Genre, :count).by(0)
      end

      it 'updates an genre on update' do
        params = {:genre => {:name => Faker::Name.name}}
        expect {
          make_request(:put, "/genres/#{@genre.id}", params)
          response.should be_valid_json
          Genre.find(response.parsed_body[:id]).name.should eq(params[:genre][:name])
        }.to change(Genre, :count).by(0)
      end

      it 'deletes an genre on delete' do
        expect {
          make_request :delete, "/genres/#{@genre.id}"
        }.to change(Genre, :count).by(-1)
      end
    end

    context 'an invalid genre' do
      before :each do
        @genre = FactoryGirl.build(:invalid_genre)
      end
      after :each do
        Genre.delete_all
      end

      it 'can not create the genre' do
        expect {
          make_request :post, '/genres', {:genre => (@genre.attributes)}
          response.should be_valid_json
          response.should be_server_error
        }.to change(Genre, :count).by(0)
      end

      it 'can not update the genre' do
        params = {:genre => {:name => Faker::Name.name}}
        expect {
          make_request(:put, "/genres/#{@genre.id}", params)
          response.should be_valid_json
          response.should be_not_found
        }.to change(Genre, :count).by(0)
      end

      it 'can not delete the genre' do
        expect {
          make_request :delete, "/genres/#{@genre.id}"
          response.should be_not_found
        }.to change(Genre, :count).by(0)
      end
    end
  end
end