require 'yaml'

module Irc2Murmur
  class FileConfig
    CONFIG_FILE = "config.yml"

    def initialize
      raise "Config file #{CONFIG_FILE} not found" unless File.exists? CONFIG_FILE
      @yaml = YAML.load_file(CONFIG_FILE)
    end

    def method_missing name, *args
      val = nil
      p1, p2 = name.to_s.split('_')
      @yaml[p1][p2].to_s
    end
  end
end
