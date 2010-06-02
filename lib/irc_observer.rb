module Irc2Murmur
  class IrcObserver
    def initialize mingle
      @mingle = mingle
    end

    def update user, message
      @mingle.post_murmur "#{user} said: #{message}"
    end

    def register bot
      bot.add_observer self
    end
  end
end
