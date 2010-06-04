require File.dirname(__FILE__) + '/../lib/irc_bot'
require File.dirname(__FILE__) + '/spec_helper'

include Irc2Murmur
describe IrcBot do
  context "sending IRC messages to the server" do
    before(:each) do
      @socket = StubSocket.new
      @bot = IrcBot.new(@socket)
    end

    it "should post nick_name with NICK to the server when setting nick" do
      @socket.should_receive(:puts).with("NICK nick")
      @bot.set_nick "nick"
    end

    it "should post username and FullName with USER to the server when setting user" do
      @socket.should_receive(:puts).with("USER username 0 * FullName")
      @bot.set_user "username", "FullName"
    end

    it "should post the channel name with JOIN to the server when joining channel" do
      @socket.should_receive(:puts).with("JOIN #channel")
      @bot.join_channel "channel"
    end

    it "should post the message with PRIVMSG and channel name when posting to a channel" do
      @socket.should_receive(:puts).with("PRIVMSG #channel :message")
      @bot.post_message "channel", "message"
    end

    it "should post QUIT to the server when quitting" do
      @socket.should_receive(:puts).with("QUIT")
      @bot.quit
    end

    it "should post a PONG to the source if the message is a PING" do
      @socket.should_receive(:puts).with("PONG sdqali")
      @bot.process "PING :sdqali"
    end

    it "should call 'changed' when the message is a PRIVMSG" do
      @bot.should_receive(:changed)
      @bot.process ":sdqali!~sadiquea@122.172.159.100 PRIVMSG #studios-solutions :hi"
    end

    it "should notify its observers with nick and message if message is a PRIVMSG" do
      @bot.should_receive(:notify_observers).with("sdqali", "hi")
      @bot.process ":sdqali!~sadiquea@122.172.159.100 PRIVMSG #channel :hi"
    end
  end
end
