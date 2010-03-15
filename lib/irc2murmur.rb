require File.dirname(__FILE__)+'/irc_bot'

module Irc2Murmur
  def self.run(config=DummyConfig.new)
    bot = IrcBot.new config.irc_server, config.irc_port
    bot.set_nick config.irc_nick
    bot.set_user config.irc_username, config.irc_realname
    bot.join_channel config.irc_channel
    mingle = Mingle.new(config.mingle_host, config.mingle_port, config.mingle_project, config.mingle_user, config.mingle_password)
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

  class DummyConfig
    def irc_server() "irc.freenode.net" end
    def irc_port() "6667" end
    def irc_channel() "studios-solutions" end
    def irc_realname() "I2M Bot" end
    def irc_username() "i2mbot" end
    def irc_nick() "i2mbot" end
    def mingle_host() "http://localhost" end
    def mingle_port() "8080" end
    def mingle_user() "i2mbot" end
    def mingle_password() "password" end
    def mingle_project() "i2mdemo" end
  end
end
