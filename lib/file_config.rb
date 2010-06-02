module Irc2Murmur
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
