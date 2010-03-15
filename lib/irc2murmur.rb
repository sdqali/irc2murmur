
module Irc2Murmur
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
