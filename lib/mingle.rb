module Irc2Murmur
  class Mingle
    def initialize http_client, protocol, host, port, project, user, password, certs
      @http_client = http_client
      @http_client.set_auth("#{protocol}://#{host}:#{port}", user, password)
      @murmurs_url = "#{protocol}://#{host}:#{port}/api/v2/projects/#{project}/murmurs.xml"
    end

    def post_murmur body
      @http_client.post(@murmurs_url, {"murmur[body]" => body})
    end
  end
end
