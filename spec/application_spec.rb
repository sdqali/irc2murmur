require File.dirname(__FILE__)+'/../lib/irc2murmur'

include Irc2Murmur
describe Application do
  it "should register the bot with the observer" do
    bot = StubBot.new
    observer = mock
    observer.should_receive(:register).with(bot)
    Application.new(bot, observer).run
  end

  it "should run the bot" do
    bot = mock
    observer = StubObserver.new
    bot.should_receive(:run)
    Application.new(bot, observer).run
  end
end

class StubObserver
  def register bot
  end
end

class StubBot
  def run
  end
end
