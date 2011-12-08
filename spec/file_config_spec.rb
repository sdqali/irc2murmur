require File.dirname(__FILE__) + '/../lib/file_config'

include Irc2Murmur
describe FileConfig do
  before(:all) do
    Dir.chdir 'spec/data'
    @config = FileConfig.new
  end
  after do
    Dir.chdir '../../'
  end

  it "parses the irc server" do
    @config.irc_server.should == 'irc.freenode.net'
  end
  
  it "parses the irc port" do
    @config.irc_port.should == '6667'
  end
  
  it "parses the irc channel name" do
    @config.irc_channel.should == 'foobar'
  end

  it "parses the irc nick" do
    @config.irc_nick.should == 'i2mbot'
  end

  it "parses the irc username" do
    @config.irc_username.should == 'i2mbot'
  end

  it "parses the irc realname" do
    @config.irc_realname.should == 'I2M Bot'
  end

  it "it parses the mingle protocol" do
    @config.mingle_protocol.should == 'http'
  end

  it "it parses the mingle host" do
    @config.mingle_host.should == 'localhost'
  end

  it "it parses the mingle project name" do
    @config.mingle_project.should == 'i2mdemo'
  end

  it "it parses the mingle user name" do
    @config.mingle_user.should == 'i2mbot'
  end

  it "it parses the mingle password" do
    @config.mingle_password.should == 'password'
  end
end
