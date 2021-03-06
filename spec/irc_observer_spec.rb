require File.dirname(__FILE__) + '/../lib/irc_observer'

include Irc2Murmur
describe IrcObserver do
  it "should add itself as observer to the bot" do
    bot = mock
    observer = IrcObserver.new nil
    bot.should_receive(:add_observer).with(observer)
    observer.register bot
  end

  it "should ask Mingle to post a murmur on being notified" do
    bot = mock
    mingle = mock
    bot.stub!(:add_observer)
    observer = IrcObserver.new mingle
    observer.register bot

    mingle.should_receive(:post_murmur).with("foo said: bar")
    observer.update "foo", "bar"
  end
end
