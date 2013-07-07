require 'spec_helper'

describe Album do

  it 'has a valid factory' do
    create(:album).should be_valid
  end

  it 'is invalid without a title' do
    build(:title_invalid_album).should_not be_valid
  end

  it 'is invalid without isbn' do
    build(:isbn_invalid_album).should_not be_valid
  end

  it 'is invalid without publisher' do
    build(:publisher_invalid_album).should_not be_valid
  end

  it 'is invalid without one or more artists' do
    build(:artists_invalid_album).should_not be_valid
  end

  it 'is invalid without one or more genres' do
    build(:genres_invalid_album).should_not be_valid
  end

  it 'is invalid without one or more tracks' do
    build(:tracks_invalid_album).should_not be_valid
  end

  it 'is invalid without published_date' do
    build(:published_date_invalid_album).should_not be_valid
  end

  it 'is invalid with incorrect min title string length' do
    build(:title_min_length_invalid_album).should_not be_valid
  end

  it 'is invalid with incorrect max title string length' do
    build(:title_max_length_invalid_album).should_not be_valid
  end

  it 'is invalid with incorrect max publisher string length' do
    build(:publisher_max_length_invalid_album).should_not be_valid
  end

  it 'is invalid with incorrect isbn format' do
    build(:isbn_format_invalid_album).should_not be_valid
  end

  it 'is invalid with incorrect min isbn string length' do
    build(:isbn_min_length_invalid_album).should_not be_valid
  end

  it 'is invalid with incorrect max isbn string length' do
    build(:isbn_max_length_invalid_album).should_not be_valid
  end
end