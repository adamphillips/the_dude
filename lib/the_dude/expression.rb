module TheDude
  class Expression
    PLACEHOLDER_REGEX = /\s\:(\S+)/

    # [String | Regexp] The expression
    attr_reader :expression

    # Creates a new Expression instance
    #
    # @param [String | Regexp] The expression
    #
    # @return [TheDude::Expression]
    def initialize expr
      @expression = expr
    end

    # Converts the expression to a regex.
    # If the expression is a string, it is converted to a regex that exactly
    # matches the string. If the expression contains variable placeholders,
    # they are substituted for the associated regexs
    #
    # @return [Regexp]
    def to_regex
      # If we have a string, escape it turn it into a regex and send it back
      return /^#{Regexp.quote @expression}$/ if @expression.kind_of? String

      substitute_all_variables
      check_for_undefined_variables

      return @expression
    end

    private

    # @return [Boolean] Whether the expression contains the specified variable
    def contains_variable? var
      @expression.source.match /\:#{var.name.to_s}/
      #@expression.source.match PLACEHOLDER_REGEX
    end

    # Returns boolean as to whether any undefined variables are declared
    # @return [Boolean] True if there are undefined variables
    def check_for_undefined_variables
      return false if @expression.kind_of? String
      vars = @expression.source.scan(PLACEHOLDER_REGEX)[0]
      return false if vars.nil?
      vars = vars.map{|v| v.strip.to_sym}
      raise TheDude::UndefinedVariableError.new("Undefined variables : #{(vars - TheDude.variables.keys).join(' ')} in #{@expression}") if (vars - TheDude.variables.keys).any?
    end

    # [Regexp] Substitues the specified variable for its pattern and converts
    # the result back to a regex
    def substitute_variable var
      subbed = @expression.source.gsub(/\:#{var.name}(\s|$)/, "(#{var.pattern.source}) ")
      subbed.strip! if subbed
      Regexp.new subbed
    end

    # Substitutes all variables in the expression for their pattern
    def substitute_all_variables
      TheDude.variables.each do |key, val|
        @expression = substitute_variable(val) if contains_variable? val
      end
    end
  end
end
