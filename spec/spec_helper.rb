# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Set the Ruby LOAD_PATH so specs can move around easier
$:.unshift File.dirname(__FILE__)

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

# Monkey patch some helpers to make life easier
module JSONHelper

  # Symbolize the keys for the headers hash
  # @return [Hash], the headers hash with symbolized keys
  def with_symbolized_headers(&block)
    headers.nil? ? false : block.call(headers.transform_keys { |key| key.to_s.downcase.gsub(/-/, '_').to_sym })
  end

  # Helper to determine whether the content type header contain a valid application/json string
  # @param [Hash], headers
  # @return [Boolean]
  def valid_json_headers?(headers)
    headers.has_key?(:content_type) && headers[:content_type] =~ %r{application/json}
  end

  # Helper to check and parse JSON body
  # @return [Boolean]
  # @raise RSpec::Expectations::ExpectationNotMetError
  def with_json_parsed_body(&block)
    if body && body.length >= 2
      block.call(JSON.parse(body.gsub(/\s/, '')))
    end
  end

  def valid_json_body?(body)
    body.is_a?(Hash) || body.is_a?(Array)
  end

  def valid_json?
    with_symbolized_headers { |headers| valid_json_headers?(headers) } if with_json_parsed_body { |body| valid_json_body?(body) }
  end
end

class ActionDispatch::TestResponse
  include JSONHelper
end

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods
  config.include JSONHelper
end
