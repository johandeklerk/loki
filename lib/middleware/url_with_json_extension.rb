module Loki
  module Middleware
# Simple Rack middleware class to add a '.json' extension to the URL if needed
# It enables a client to use URL's such as /artists instead of /artists.json
    class UrlWithJSONExtension

      def initialize(app)
        @app = app
      end

      def call(env)
        req = Rack::Request.new(env)
        unless req.path_info == '/'
          req.path_info = "#{req.path_info}.json" unless req.path_info =~ /.+\.json$/
        end
        @app.call(env)
      end
    end
  end
end