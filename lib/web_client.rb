require File.dirname(__FILE__) + '/utils'
require 'rubygems'
require 'httpclient'

module Irc2Murmur
  class WebClient
    def initialize() @client = HTTPClient.new end

    def post url, params
      response_from @client.post url, params
    end

    def put url, params
      content_type = {'Content-Type' => 'application/x-www-form-urlencoded'}
      response_from @client.put url, params, content_type
    end
    
    def get url
      response_from @client.get url
    end

    def authenticate username, password
      @client.set_auth nil, username, password
    end

    class Response
      attr_reader :status, :body, :headers
      def initialize status, body, headers
        @status = status; @body = body; @headers = headers
      end
    end

    private
    def response_from lib_response
      headers = lib_response.header.all.
        inject({}) {|acc, (key, value)| acc.merge key=>value }
      Response.new lib_response.status, lib_response.content, headers
    end
  end
  
  class AuthenticatingWebClient
    include Decorator
    def initialize username, password
      @username = username; @password = password
    end

    def post url, params
      authenticate
      wrapped.post url, params
    end

    def put url, params
      authenticate
      wrapped.put url, params
    end

    def get url
      authenticate
      wrapped.get url
    end

    private
    def authenticate
      wrapped.authenticate @username, @password
    end
  end

  class LoggingWebClient
    include Decorator
    def initialize logger
      @logger = logger
    end

    def get url
      @logger.webclient_get_before url
      response = wrapped.get url
      @logger.webclient_get_after response
      response
    end

    def post url, params
      @logger.webclient_post_before(url, params)
      response = wrapped.post url, params
      @logger.webclient_post_after(response)
      response
    end

    def put url, params
      @logger.webclient_put_before(url, params)
      response = wrapped.put url, params
      @logger.webclient_put_after(response)
      response
    end
  end

  class ResponseValidatingWebClient
    include Decorator

    def get url
      checking_response(url) { wrapped.get(url) }
    end

    def post url, params
      checking_response(url) { wrapped.post(url, params) }
    end

    def put url, params
      checking_response(url) { wrapped.put(url, params) }
    end
    
    private
    def checking_response url
      response = yield
      success?(response) or raise error_for(url, response)
      response
    end
    
    def success? response
      [200,201].include?(response.status)
    end

    def error_for url, response
      error = not_found?(response) ? HttpNotFoundError : HttpResponseError
      error.new(response.status, url, response.body)
    end

    def not_found? response
      response.status == 404
    end
  end

  class HttpResponseError < Exception
    attr_reader :status, :url, :response_body
    def initialize status, url, response_body
      @status = status
      @url = url
      @response_body = response_body
    end
  end

  class HttpNotFoundError < HttpResponseError ; end
end
