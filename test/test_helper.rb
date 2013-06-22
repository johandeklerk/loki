ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
end

module ActionController
  class ApiTestCase < TestCase
    attr_reader :parsed_body

    def process(action, http_method = 'GET', *args)
      super(action, http_method, *args)
      # Make the headers nicer to deal with.
      response.headers = response.headers.transform_keys { |key| key.to_s.downcase.gsub('-', '_').to_sym }
      # Always parse the response body into a Hash and symbolize keys
      begin
        @parsed_body ||= JSON.parse(response.body).symbolize_keys
      rescue => e
        puts "Response body not valid JSON?"
        raise e
      end
    end
  end
end