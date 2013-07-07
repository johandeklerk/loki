require 'spec_helper'

describe Genre do

  before do
    Genre.delete_all
  end

  it 'has a valid factory' do
    create(:genre).should be_valid
  end

  it 'is invalid without a name' do
    build(:invalid_name_genre).should_not be_valid
  end
end