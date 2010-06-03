require File.dirname(__FILE__) + '/../lib/irc_bot'
require File.dirname(__FILE__) + '/../lib/mingle'
require File.dirname(__FILE__)+'/spec_helper'

include Irc2Murmur
describe Mingle do
  it "should authenticate with correct credentials" do
    http_client = StubHttpClient.new
    http_client.should_receive(:set_auth).with("http://host:8080", "user", "password")
    Mingle.new(http_client, "host", 8080, "test_project", "user", "password")
  end

  context "posting murmurs" do
    it "post to the correct mingle server" do
      http_client = StubHttpClient.new
      http_client.should_receive(:post).with(%r{.*://host:8080/.*}, anything)
      Mingle.new(http_client, "host", 8080, nil, nil, nil).post_murmur(nil)
    end

    it "should posts to the correct url" do
      http_client = StubHttpClient.new
      http_client.should_receive(:post).with(%r{.*/api/v2/projects/the-project/murmurs.xml}, anything)
      Mingle.new(http_client, nil, nil, "the-project", nil, nil).post_murmur(nil)
    end

    it "posts in the correct format" do
      http_client = StubHttpClient.new
      http_client.should_receive(:post).with(anything, "murmur[body]" => "foo")
      Mingle.new(http_client, nil, nil, nil, nil, nil).post_murmur("foo")
    end
  end
end
