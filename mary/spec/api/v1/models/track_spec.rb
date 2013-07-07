require 'spec_helper'

describe Track do
  it 'has a valid factory' do
    FactoryGirl.create(:track).should be_valid
  end

  it 'is invalid without a title' do
    FactoryGirl.build(:invalid_title_track).should_not be_valid
  end
end