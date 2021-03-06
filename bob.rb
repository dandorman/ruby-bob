class Bob
  def hey(message)
    Message.classify(message).response
  end

  class Message
    def self.classify(message)
      message = message.to_s
      types.detect { |type| type.handles? message }.new
    end

    def self.types
      @types ||= [self]
    end

    def self.inherited(child)
      types.unshift(child)
    end

    def self.handles?(message)
      true
    end

    def response
      "Whatever."
    end
  end

  class Shout < Message
    def self.handles?(message)
      message.upcase == message
    end

    def response
      "Woah, chill out!"
    end
  end

  class Question < Message
    def self.handles?(message)
      message.end_with? ??
    end

    def response
      "Sure."
    end
  end

  class Empty < Message
    def self.handles?(message)
      message.strip.empty?
    end

    def response
      "Fine. Be that way."
    end
  end
end
