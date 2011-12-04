require File.dirname(__FILE__) + '/../lib/irc_bot'
require File.dirname(__FILE__) + '/../lib/mingle'

include Irc2Murmur
describe Mingle do
  context "authenticating" do
    it "should authenticate with the correct server" do
      http_client = mock
      http_client.should_receive(:set_auth).with("protocol://host:8080", anything, anything)
      Mingle.new(http_client, "protocol", "host", 8080, nil, nil, nil, nil)
    end

    it "should authenticate with the correct username" do
      http_client = mock
      http_client.should_receive(:set_auth).with(anything, "user", anything)
      Mingle.new(http_client, nil, nil, nil, nil, "user", nil, nil)
    end

    it "should authenticate with the correct password" do
      http_client = mock
      http_client.should_receive(:set_auth).with(anything, anything, "password")
      Mingle.new(http_client, nil, nil, nil, nil, nil, "password", nil)
    end
  end

  context "posting murmurs" do
    before :each do
      @http_client = mock
      @http_client.stub!(:set_auth)
    end

    it "post to the correct mingle server" do
      @http_client.should_receive(:post).with(%r{protocol://host:8080/.*}, anything)
      Mingle.new(@http_client, "protocol", "host", 8080, nil, nil, nil, nil).post_murmur(nil)
    end

    it "should posts to the correct url" do
      @http_client.should_receive(:post).with(%r{.*/api/v2/projects/the-project/murmurs.xml}, anything)
      Mingle.new(@http_client, nil, nil, nil, "the-project", nil, nil, nil).post_murmur(nil)
    end

    it "posts in the correct format" do
      @http_client.should_receive(:post).with(anything, "murmur[body]" => "foo")
      Mingle.new(@http_client, nil, nil, nil, nil, nil, nil, nil).post_murmur("foo")
    end
  end
end
