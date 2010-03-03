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

  context "sending IRC messages to the server" do
    before(:each) do
      @mock_socket = mock(TCPSocket)
      TCPSocket.should_receive(:open).and_return(@mock_socket)
      @bot = IrcBot.new(nil, nil)
    end

    it "should post nick_name with NICK to the server when setting nick" do
      @bot.should_receive(:post).with("NICK nick")
      @bot.set_nick "nick"
    end

    it "should post username and FullName with USER to the server when setting user" do
      @bot.should_receive(:post).with("USER username 0 * FullName")
      @bot.set_user "username", "FullName"
    end

    it "should post the channel name with JOIN to the server when joining channel" do
      @bot.should_receive(:post).with("JOIN #channel")
      @bot.join_channel "#channel"
    end

    it "should post the message with PRIVMSG and channel name when poting to a channel" do
      @bot.should_receive(:post).with("PRIVMSG #channel :message")
      @bot.post_message "#channel", "message"
    end

    it "should post QUIT to the server when quitting" do
      @bot.should_receive(:post).with("QUIT")
      @bot.quit
    end

    it "should post a PONG to the source if the message is a PING" do
      @bot.should_receive(:post).with("PONG sdqali")
      @bot.process "PING :sdqali"
    end

    it "should call 'changed' when the message is a PRIVMSG" do
      @bot.should_receive(:changed)
      @bot.process ":sdqali!~sadiquea@122.172.159.100 PRIVMSG #studios-solutions :hi"
    end

    it "should notify its observers with nick and message if message is a PRIVMSG" do
      @bot.should_receive(:notify_observers).with("sdqali", "hi")
      @bot.process ":sdqali!~sadiquea@122.172.159.100 PRIVMSG #studios-solutions :hi"
    end
  end
end
