require 'spec_helper'

describe Publisher do
  it 'has a valid factory' do
    FactoryGirl.create(:publisher).should be_valid
  end

  it 'is invalid without a name' do
    FactoryGirl.build(:invalid_name_publisher).should_not be_valid
  end
end