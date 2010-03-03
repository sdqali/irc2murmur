require File.dirname(__FILE__) + '/../lib/irc_bot'

describe IrcObserver do
  it "should add itself as observer to the bot" do
    bot = mock(IrcBot)
    bot.should_receive(:add_observer)
    IrcObserver.new bot
  end
end

