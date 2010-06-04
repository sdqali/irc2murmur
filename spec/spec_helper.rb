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
  def set_auth domain, user, password
  end
end

class StubSocket
  def puts
  end
end
