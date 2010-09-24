require 'rubygems'
require 'hardmock'
require 'ostruct'

Spec::Runner.configure do |configuration|
  include Hardmock
  configuration.after(:each) { verify_mocks }
end
# Hardmock allows us to make cross-mock ordering expectations
def strict_order_mocks(*mocks)
  include Hardmock
  create_mocks *mocks
end
def strict_order_mock(mock) strict_order_mocks mock end

def load_files(*files)
  base_dir = File.dirname(__FILE__) + '/../lib/'
  files.each do |f|
    if (f == 'mingle_connector' || f == 'mingle_connector.rb')
      require base_dir + f
    else
      require base_dir + 'mingle_connector/' + f
    end
  end
end

alias :load_file :load_files

class StubObserver
  def register bot
  end
end

class StubBot
  def run
  end

  def add_observer observer
  end
end

class StubHttpClient
  def initialize
    @ssl_config = StubSslConfig.new
  end

  def set_auth domain, user, password
  end

  def ssl_config
    @ssl_config
  end
end

class StubSocket
  def puts
  end
end

class StubSslConfig
  def initialize
  end

  def set_trust_ca location
  end
end
