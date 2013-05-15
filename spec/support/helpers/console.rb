module TestHelpers
  # Helpers to make life in the terminal a little more pleasant
  # Include them in rspec by adding
  #   include TestHelpers::Console
  #
  # to spec_helper.rb
  module Console
    # Colour handling functionality
    module Colors
      # Standard terminal color codes
      COLORS = {
        :reset => '0',
        :bold => '1',
        :red => '31',
        :green => '32',
        :yellow => '33',
        :blue => '34',
        :magenta => '35',
        :cyan => '36',
        :white => '37'
      }

      # Colours the specified text by prepending it with the standard terminal
      # colour code for the specified colour. A reset code is appended in order
      # to avoid accidentally colourising subsequent text.
      #
      # @param [String] text  The text to colourise
      # @param [Symbol] color The colour to use
      #
      # @return [String] The colourised string
      def color(text, color)
        if COLORS[color]
          "#{start_color color}#{text}#{reset_color}"
        end
      end

      # The terminal reset code
      #
      # @return [String]
      def reset_color
        "\e[#{COLORS[:reset]}m"
      end

      # The code for the specified colour with the necessary escape characters
      #
      # @return [String]
      def start_color color
        "\e[#{COLORS[color]}m"
      end
    end

    # Functions for outputting to the terminal
    module Output
      # Outputs the passed variable
      #
      # @param [Object] var    The variable to be output
      # @param [Symbol] colour The colour to use
      # @param [String] title  A descriptive title
      def out var, colour=nil, title=''
        #title ||= caller[0][/`([^']*)'/, 1]
        loc = caller[0].scan(/[\s\/]`?([^\/:.']+)?/)[-2..-1].join(':')
        title = " #{color(title, colour)} :" unless title == ''
        out = var.inspect
        out = "|> #{color(loc, colour)} :>#{title} #{color(out, colour)}"
        puts color(out, colour)
      end
    end

    def self.included base
      base.send :include, Output
      base.send :include, Colors
    end

  end
end


