require 'test_helper'

class ApiControllerTest < ActionController::TestCase

  test "root path must return JSON error" do
    get :index
    assert_response :success
    assert_equal @response.body, {:error => 'URL must be in the format VERSION/RESOURCE'}.to_json
  end
end