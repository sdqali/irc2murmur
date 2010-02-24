require File.dirname(__FILE__) + '/../lib/irc_bot'

describe IrcBot do
  context "when establishing connections to the server" do
    it "should open a TCP socket at specified server when initialized" do
      TCPSocket.should_receive(:open).with("server", anything())
      IrcBot.new "server", nil
    end

    it "should open a TCP socket at specified port when initialized" do
      TCPSocket.should_receive(:open).with(anything(), "port")
      IrcBot.new nil, "port"
    end
  end

  context "when posting messages" do
    it "should put all messages to the socket" do
      mock_socket = mock(TCPSocket)
      TCPSocket.should_receive(:open).and_return(mock_socket)
      mock_socket.should_receive(:puts).with("message")
      IrcBot.new(nil, nil).post "message"
    end
  end

  context "when setting nick" do
    it "should post nick_name with NICK to the server" do
      mock_socket = mock(TCPSocket)
      TCPSocket.should_receive(:open).and_return(mock_socket)
      bot = IrcBot.new(nil, nil)
      bot.should_receive(:post).with("NICK nick")
      bot.set_nick "nick"
    end
  end

  context "when setting user" do
    it "should post username and FullName with USER to the server" do
      mock_socket = mock(TCPSocket)
      TCPSocket.should_receive(:open).and_return(mock_socket)
      bot = IrcBot.new(nil, nil)
      bot.should_receive(:post).with("USER username 0 * FullName")
      bot.set_user "username", "FullName"
    end
  end

  context "when joining a channel" do
    it "should post the channel name with JOIN to the server " do
      mock_socket = mock(TCPSocket)
      TCPSocket.should_receive(:open).and_return(mock_socket)
      bot = IrcBot.new(nil, nil)
      bot.should_receive(:post).with("JOIN #channel")
      bot.join_channel "#channel"
    end
  end

  context "when sending a message" do
    it "should post the message with PRIVMSG and channel name" do
      mock_socket = mock(TCPSocket)
      TCPSocket.should_receive(:open).and_return(mock_socket)
      bot = IrcBot.new(nil, nil)
      bot.should_receive(:post).with("PRIVMSG #channel :message")
      bot.post_message "#channel", "message"
    end
  end

  context "when quitting" do
    it "should post QUIT to the server" do
      mock_socket = mock(TCPSocket)
      TCPSocket.should_receive(:open).and_return(mock_socket)
      bot = IrcBot.new(nil, nil)
      bot.should_receive(:post).with("QUIT")
      bot.quit
    end
  end

  context "when processing incoming messages" do
    it "should post a PONG to the source if the message is a PING" do
      mock_socket = mock(TCPSocket)
      TCPSocket.should_receive(:open).and_return(mock_socket)
      bot = IrcBot.new(nil, nil)
      bot.should_receive(:post).with("PONG sdqali")
      bot.process "PING :sdqali"
    end
  end
end
