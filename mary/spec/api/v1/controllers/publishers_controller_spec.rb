require 'spec_helper'

describe Api::V1::PublishersController do

  describe 'with no publishers' do
    before :each do
      Publisher.delete_all
    end

    it 'creates an publisher on create' do
      expect {
        make_request :post, '/publishers', {:publisher => (new_publisher = FactoryGirl.build(:publisher)).attributes}
        response.should be_valid_json
        Publisher.find(response.parsed_body[:id]).name.should eq(new_publisher.name)
      }.to change(Publisher, :count).by(1)
    end

    it 'does not show the publisher' do
      expect {
        make_request :get, "/publishers/234234234234"
        response.should be_valid_json
        response.should be_not_found
        expect(response.raw_body).to eq('{}')
      }.to change(Publisher, :count).by(0)
    end
  end

  describe 'with a test publisher' do
    context 'a valid publisher' do
      before :each do
        @publisher = FactoryGirl.create(:publisher)
      end

      after :each do
        Publisher.delete_all
      end

      it 'provides valid JSON on index' do
        expect {
          make_request :get, '/publishers'
          response.should be_valid_json
          response.parsed_body.count.should eq(Publisher.count)
        }.to change(Publisher, :count).by(0)
      end

      it 'provides a valid JSON publisher string on show' do
        expect {
          make_request :get, "/publishers/#{@publisher.id}"
          response.should be_valid_json
          expect(response.raw_body).to eq(@publisher.to_json)
        }.to change(Publisher, :count).by(0)
      end

      it 'updates an publisher on update' do
        params = {:publisher => {:name => Faker::Name.name}}
        expect {
          make_request(:put, "/publishers/#{@publisher.id}", params)
          response.should be_valid_json
          Publisher.find(response.parsed_body[:id]).name.should eq(params[:publisher][:name])
        }.to change(Publisher, :count).by(0)
      end

      it 'deletes an publisher on delete' do
        expect {
          make_request :delete, "/publishers/#{@publisher.id}"
        }.to change(Publisher, :count).by(-1)
      end
    end

    context 'an invalid publisher' do
      before :each do
        @publisher = FactoryGirl.build(:invalid_publisher)
      end
      after :each do
        Publisher.delete_all
      end

      it 'can not create the publisher' do
        expect {
          make_request :post, '/publishers', {:publisher => (@publisher.attributes)}
          response.should be_valid_json
          response.should be_server_error
        }.to change(Publisher, :count).by(0)
      end

      it 'can not update the publisher' do
        params = {:publisher => {:name => Faker::Name.name}}
        expect {
          make_request(:put, "/publishers/#{@publisher.id}", params)
          response.should be_valid_json
          response.should be_not_found
        }.to change(Publisher, :count).by(0)
      end

      it 'can not delete the publisher' do
        expect {
          make_request :delete, "/publishers/#{@publisher.id}"
          response.should be_not_found
        }.to change(Publisher, :count).by(0)
      end
    end
  end
end