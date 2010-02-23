class IrcBot
  def initialize server, port, channel, user_name, nick
    @server = server
    @port  = port
  end

  def open_connection
    TCPSocket.open(@server, @port)
  end
end
