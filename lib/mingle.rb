module Irc2Murmur
  class Mingle
    def initialize host, port, project, user, password
      @http_client = HTTPClient.new
      @http_client.set_auth("http://#{host}:#{port}", user, password)
      @murmurs_url = "http://#{host}:#{port}/api/v2/projects/#{project}/murmurs.xml"
    end

    def post_murmur body
      @http_client.post(@murmurs_url, {"murmur[body]" => body})
    end
  end
end
