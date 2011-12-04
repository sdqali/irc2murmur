require 'yaml'

module Irc2Murmur
  class FileConfig
    def initialize
      @yaml = YAML.load_file('config.yml')
    end

    def method_missing name, *args
      val = nil
      p1, p2 = name.to_s.split('_')
      @yaml[p1][p2].to_s
    end
  end
end
