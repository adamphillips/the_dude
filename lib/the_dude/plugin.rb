module TheDude
  # Plugins can contain additional commands or integrate other tools into the
  # dude
  class Plugin
    # [String] The name of the plugin
    attr_reader :name

    # Intializes a new TheDude::Plugin instance
    def initialize name
      @name = name
    end

    def gem_name
      @gem_name ||= "the_dude-#{name}"
    end

    class << self
      # Returns all the plugins that are installed. This works by examining the
      # installed gems. Any installed gem whose name begins with the_dude- is
      # assumed to be a plugin for The Dude
      def all
        begin
          Gem::Specification.latest_specs.   # Get all the installed gems
            collect{|s| s.name}.     # Collect the names
            grep(/the_dude\-/).     # Filter for those beginning with the_dude-
            map{|s| TheDude::Plugin.new s[9..s.length]} #   Trim off the prefix
                                                       # and convert to Plugin instance
        rescue
          []
        end
      end
    end
  end
end
