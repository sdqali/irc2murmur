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

  class Mingle
    def initialize host, port, project, user, password
      @http_client = HTTPClient.new
      @http_client.set_auth("http://#{host}:#{port}", user, password)
      @murmurs_url = "http://#{host}:#{port}/api/v2/projects/#{project}/murmurs.xml"
    end

    def post_murmur body
      @http_client.post(@murmurs_url, {"murmur[body]" => body})
    end
  end

  class FileConfig
    def initialize
      @yaml = YAML.load_file('config.yml')
    end
    
    def irc_server
      @yaml['irc']['server']
    end

    def irc_port
      @yaml['irc']['port'].to_s
    end

    def irc_channel
      @yaml['irc']['channel']
    end

    def irc_nick
      @yaml['irc']['nick']
    end

    def irc_username
      @yaml['irc']['username']
    end

    def irc_realname
      @yaml['irc']['realname']
    end

    def mingle_host
      @yaml['mingle']['host']
    end

    def mingle_port
      @yaml['mingle']['port'].to_s
    end

    def mingle_project
      @yaml['mingle']['project']
    end

    def mingle_user
      @yaml['mingle']['user']
    end

    def mingle_password
      @yaml['mingle']['password']
    end
  end
end
