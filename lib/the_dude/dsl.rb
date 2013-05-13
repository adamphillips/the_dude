module TheDude
  module Dsl
    def command *args, &block
      TheDude::Command.new *args, &block
    end
  end
end
