require File.dirname(__FILE__) + '/../lib/irc_bot'

describe IrcBot do
  it "should open a TCP socket at specified server when connection opened" do
    TCPSocket.should_receive(:open).with("server", anything())
    IrcBot.new("server", nil, nil, nil, nil).open_connection
  end

  it "should open a TCP socket at specified port when connection opened" do
    TCPSocket.should_receive(:open).with(anything(), "port")
    IrcBot.new(nil, "port", nil, nil, nil).open_connection
  end
end
