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

    # Class methods
    class << self
      # Runs the specified code inside an instance of the DSL
      #
      # @param [String] code Code to run
      def run code
        new.instance_eval code
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
