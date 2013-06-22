require 'test_helper'

class ArtistsControllerTest < ActionController::TestCase

  test 'responds to index' do
    get :index, :format => :json
    assert_response :success
  end
end
