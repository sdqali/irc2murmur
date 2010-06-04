require 'socket'
require 'observer'
require 'logger'
require 'net/http'
require 'rubygems'
require 'httpclient'
require 'yaml'

module Irc2Murmur
  class IrcBot
    include Observable
    def initialize socket
      @socket = socket
    end

    def set_nick nick
      post "NICK #{nick}"
    end

    def set_user user_name, full_name
      post "USER #{user_name} 0 * #{full_name}"
    end
    
    def post message
      @socket.puts message
    end

    def join_channel channel
      @channel = "##{channel}"
      post "JOIN #{@channel}"
    end

    def post_message channel, message
      post "PRIVMSG ##{channel} :#{message}"
    end

    def quit
      post "QUIT"
    end

    def process message
      if message.match(/^PING :(.*)$/)
        post "PONG #{$~[1]}"
      elsif message.match(/PRIVMSG #{@channel}(.*)$/)
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
end
