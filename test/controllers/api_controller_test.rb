require 'test_helper'

class ApiControllerTest < ActionController::ApiTestCase

  test "root path must return JSON error" do
    get :index
    assert_response :bad_request
    assert response.headers[:content_type] =~ /#{Mime::JSON.to_s}/
    assert parsed_body.is_a?(Hash), "Body could not be parsed, invalid JSON? \n #{response.body}"
    assert parsed_body.keys.include?(:error), "No error key: #{parsed_body}"
  end
end