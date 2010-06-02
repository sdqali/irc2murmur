require File.dirname(__FILE__) + '/../lib/irc_bot'
require File.dirname(__FILE__) + '/../lib/mingle'
require File.dirname(__FILE__)+'/spec_helper'

include Irc2Murmur
describe Mingle do
  it "should create an httpclient with the config" do
    http_client = StubHttpClient.new
    HTTPClient.should_receive(:new).and_return(http_client)
    http_client.should_receive(:set_auth).with("http://host:8080", "user", "password")
    Mingle.new("host", 8080, "test_project", "user", "password")
  end

  it "should post murmur to mingle server" do
    http_client = StubHttpClient.new
    HTTPClient.stub!(:new).and_return(http_client)
    http_client.should_receive(:post).with("http://host:8080/api/v2/projects/test_project/murmurs.xml", "murmur[body]" => "foo")
    Mingle.new("host", 8080, "test_project", "user", "password").post_murmur("foo")
  end
end
