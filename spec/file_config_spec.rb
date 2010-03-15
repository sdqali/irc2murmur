require File.dirname(__FILE__) + '/../lib/irc_bot'

include Irc2Murmur
describe FileConfig do
  before(:all) do
    Dir.chdir 'spec/data'
    @config = FileConfig.new
  end
  after do
    Dir.chdir '../../..'
  end
  
  it "parses the irc server" do
    @config.irc_server.should == 'irc.freenode.net'
  end

  it "parses the irc port" do
    @config.irc_port.should == '6667'
  end
end
