# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Helpers to validate JSON responses
module JSONHelpers
  # raw body contains the JSON string and parsed_body the parsed JSON data structure
  attr_accessor :raw_body, :parsed_body

  # Helper that combines all the below methods for use in specs
  # @return [Boolean]
  def valid_json?
    with_symbolized_headers { |headers| valid_json_headers?(headers) } if with_json_parsed_body { |body| valid_json_body?(body) }
  end

  private

  # Helper to symbolize the keys of a hash
  # @param [Hash], hash
  # @return [Hash]
  def symbolize_keys(hash)
    hash.transform_keys { |key| key.to_s.downcase.gsub(/-/, '_').to_sym }
  end

  # Symbolize the keys for the headers hash
  # @return [Hash], the headers hash with symbolized keys
  # @raise RSpec::Expectations::ExpectationNotMetError
  def with_symbolized_headers(&block)
    headers.nil? ? false : block.call(symbolize_keys(headers))
  end

  # Helper to determine whether the content type header contain a valid application/json string
  # @param [Hash], headers
  # @return [Boolean]
  # @raise RSpec::Expectations::ExpectationNotMetError
  def valid_json_headers?(headers)
    headers.has_key?(:content_type) && headers[:content_type] =~ %r{application/json}
  end

  # Helper to check and parse JSON body
  # @return [Boolean]
  # @raise RSpec::Expectations::ExpectationNotMetError
  def with_json_parsed_body(&block)
    if body && body.length >= 2
      self.raw_body = body
      self.parsed_body = JSON.parse(self.raw_body)
      self.parsed_body = symbolize_keys(self.parsed_body) if !self.parsed_body.nil? && self.parsed_body.is_a?(Hash)
      block.call(self.parsed_body)
    end
  end

  # Helper to check if body is actually valid JSON
  # @param [String], body
  # @return [Boolean]
  def valid_json_body?(body)
    body.is_a?(Hash) || body.is_a?(Array)
  end
end

# HTTP helpers to make life easier
module HTTPHelpers
  # rails-api requires a specific accept header to determine API version
  def custom_headers(version = 1)
    @headers ||= {'HTTP_ACCEPT' => "application/vnd.mary+json; version=#{version}", :format => :json}
  end

  def make_request(method, path, body = {})
    send(method, path, body, custom_headers)
  end
end

# Make our JSON helpers available to be used as matchers
class ActionDispatch::TestResponse
  include JSONHelpers
end

RSpec.configure do |config|
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Syntax sugar for factories
  config.include FactoryGirl::Syntax::Methods

  # Include our HTTP helpers for use in specs
  config.include HTTPHelpers
end