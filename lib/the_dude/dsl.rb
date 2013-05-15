module TheDude
  module Dsl
    # Forwards the call on to {TheDude.ask}
    def ask *args
      TheDude.ask *args
    end

    # Forwards the call on to {TheDude::Command.new}
    def command *args, &block
      TheDude::Command.new *args, &block
    end
  end
end
