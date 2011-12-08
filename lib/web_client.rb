require 'httparty'

class WebClient
  include HTTParty

  def base_uri uri
    @base_uri = uri
  end

  def basic_auth user, password
    @auth = {:username => user, :password => password}
  end
  
  def post path, params
    options = { :query => params, :basic_auth => @auth }
    self.class.post("#{@base_uri}#{path}", options)
  end
end
