class IrcBot
  def initialize server, port
    @socket = TCPSocket.open server, port
  end
  
  def post message
    @socket.put message
  end

  def set_nick nick
    post "NICK #{nick}"
  end

  def set_user user_name, full_name
    post "USER #{user_name} 0 * #{full_name}"
  end

  def join_channel channel
    post "JOIN #{channel}"
  end

  def post_message channel, message
    post "PRIVMSG #{channel} :#{message}"
  end

  def quit
    post "QUIT"
  end
end
