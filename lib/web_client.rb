require 'httparty'

class WebClient
  include HTTParty

  def post path, params
    self.class.post(path, :query => params)
  end
end
