require 'net/http'

module TheDude
  class Http
    # The current url being visited
    attr_reader :url

    # Initalizes a new instance
    #
    # @param [String] url The url to connect to
    #
    # @return [TheDude::Http] The new instance
    def initialize url=nil
      visit url if url
    end

    # Returns the HTML source for the current url
    def source
      raise 'No url' unless @url
      Net::HTTP.get(URI.parse(@url)).to_s
    end

    # Sets the current url
    def visit url
      @url = url
    end
  end
end
