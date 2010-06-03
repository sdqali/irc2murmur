require File.dirname(__FILE__)+'/irc_bot'
require File.dirname(__FILE__)+'/irc_observer'
require File.dirname(__FILE__)+'/file_config'
require File.dirname(__FILE__)+'/mingle'

module Irc2Murmur
  def self.run(config=FileConfig.new)
    bot = IrcBot.new TCPSocket.open(config.irc_server, config.irc_port)
    bot.set_nick config.irc_nick
    bot.set_user config.irc_username, config.irc_realname
    bot.join_channel config.irc_channel
    mingle = Mingle.new(HTTPClient.new, config.mingle_host, config.mingle_port, config.mingle_project, config.mingle_user, config.mingle_password)
    Application.new(bot, IrcObserver.new(mingle)).run
  end
  
  class Application
    def initialize bot, observer
      @observer = observer
      @bot = bot
    end

    def run
      @observer.register @bot
      @bot.run
    end
  end
end
