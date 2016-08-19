# Her::API.setup url: "https://api.pripoj.me" do |c|
#   # Request
#   c.use TokenAuthentication
#   c.use ResponseBodyLogger, ActiveSupport::Logger.new(STDOUT) if Rails.env.development?
#   c.use Faraday::Request::UrlEncoded
#
#   # Response
#   c.use Her::Middleware::MyJsonParser
#
#   # Adapter
#   c.use Faraday::Adapter::NetHttp
#   c.use Her::Middleware::AcceptJSON
# end
