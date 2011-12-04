module Irc2Murmur
  class Mingle
    def initialize http_client, protocol, host, port, project, user, password, certs
      @http_client = http_client
      @http_client.base_uri "#{protocol}://#{host}:#{port}"
      @http_client.basic_auth(user, password)
      @murmurs_url = "/api/v2/projects/#{project}/murmurs.xml"
    end

    def post_murmur body
      @http_client.post(@murmurs_url, {"murmur[body]" => body})
    end
  end
end
