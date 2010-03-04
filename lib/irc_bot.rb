require 'socket'
require 'observer'
require 'logger'

class IrcBot
  include Observable
  def initialize server, port
    @socket = TCPSocket.open server, port
  end
  
  def post message
    @socket.puts message
  end

  def set_nick nick
    post "NICK #{nick}"
  end

  def set_user user_name, full_name
    post "USER #{user_name} 0 * #{full_name}"
  end

  def join_channel channel
    post "JOIN #{channel}"
    @channel = channel
  end

  def post_message channel, message
    post "PRIVMSG #{channel} :#{message}"
  end

  def quit
    post "QUIT"
  end

  def process message
    if message.match(/^PING :(.*)$/)
      post "PONG #{$~[1]}"
    elsif message.match(/PRIVMSG(.*)$/)
      changed
      user = nick_from_message message
      msg = msg_from_message message
      notify_observers user, msg
    end
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      process msg
    end
  end

  private
  def nick_from_message message
    message.split(":")[1].split("!~")[0]
  end

  def msg_from_message message
    message.split("#{@channel} :")[1]
  end
end

class IrcObserver
  def initialize 
    @log = Logger.new('log.txt')
  end

  def update user, msg
    @log.debug "#{user} said: #{msg}"
  end

  def register bot
    bot.add_observer self
  end
end
