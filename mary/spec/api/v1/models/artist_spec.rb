require 'spec_helper'

describe Artist do
  it 'has a valid factory' do
    FactoryGirl.create(:artist).should be_valid
  end

  it 'is invalid without a name' do
    FactoryGirl.build(:invalid_name_artist).should_not be_valid
  end
end