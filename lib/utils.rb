module Irc2Murmur
  module Decorator
    attr_reader :wrapped
    def decorating(wrapped)
      @wrapped = wrapped
      self
    end
  end
end
