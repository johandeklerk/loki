require 'pp'
module Loki
  module Middleware
    # Rack middleware to add a default version header if none specified (required by api-versions gem)
    class VersionHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        unless env['HTTP_ACCEPT'] =~ /vnd\.loki/
          env['HTTP_ACCEPT'] = 'application/json,application/vnd.loki+json;'
        end
        @app.call(env)
      end
    end
  end
end