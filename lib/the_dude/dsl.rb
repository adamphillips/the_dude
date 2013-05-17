module TheDude
  class Dsl
    # Forwards the call on to {TheDude.ask}
    def ask *args
      TheDude.ask *args
    end

    # Forwards the call on to {TheDude::Command.new}
    def command *args, &block
      TheDude::Command.new *args, &block
    end

    # Forwards the call on to {TheDude.say}
    def say *args
      TheDude.say *args
    end

    # Creates and registers a new variable
    def var *args
      TheDude::Variable.new(*args).register
    end

    # Class methods
    class << self
      # Runs the specified code inside an instance of the DSL. Code can be
      # passed as a string or block. If both are given, the string is
      # ignored.
      #
      # @param [String] text Code to run
      # @param [Block]  code Code to run
      def run text=nil, &code
        if block_given?
          new.instance_exec &code
        else
          new.instance_eval text
        end
      end

      # Reads in a file and processes it using The Dude Dsl
      #
      # @param [String] path Path to the file to read
      def from_file path
        run File.read(path) if File.exists? path
      end
    end
  end
end
