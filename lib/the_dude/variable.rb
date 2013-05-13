module TheDude
  class Variable

    # [Symbol] The name of the variable
    attr_reader :name

    # [Regexp] The pattern associated with the variable
    attr_reader :pattern

    # Creates an new variable instance based on the provided name and pattern.
    #
    # @param [Symbol] name    The name of the variable
    # @param [Regexp] pattern The pattern associated with the variable
    #
    # @return [TheDude::Variable]
    def initialize name, pattern
      @name = name
      @pattern = pattern
    end

    def register
      TheDude.register_variable self
    end
  end
end
