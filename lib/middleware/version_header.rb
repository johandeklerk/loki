require 'pp'
module Loki
  module Middleware
    # Rack middleware to add a default version header if none specified (required by api-versions gem)
    class VersionHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        unversioned = 'application/json,application/vnd.loki+json;'
        env['HTTP_ACCEPT'] = env.has_key?('HTTP_API_VERSION') ? "#{unversioned}version=#{env['HTTP_API_VERSION']}" : unversioned
        @app.call(env)
      end
    end
  end
end