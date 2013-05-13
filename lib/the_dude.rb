require 'date'
require 'shellwords'

require 'hirb'
require 'colored'

require 'the_dude/command'
require 'the_dude/config'
require 'the_dude/dsl'
require 'the_dude/expression'
require 'the_dude/http'
require 'the_dude/variable'
require 'the_dude/version'

module TheDude

  class << self
    # Asks the dude a question
    def ask question
      command = find_command_for question
      return "Wtf? What do you mean #{question}" unless command
      arguments = arguments_for question, command

      # this is a nasty way of dealing with the fact that we get question
      # returned if it exactly matches the command
      arguments = nil if arguments == question

      command.ask *arguments
    end

    # @return [Hash] Returns the commands the dude knows about
    def commands
      @commands || {}
    end

    # Outputs something using angry-dude-formatting
    def complain something
      puts angry_dude_format something
    end

    # @return [Hash] Returns the variables the dude knows about
    def variables
      @variables || {}
    end

    # Registers a new command with the dude
    #
    # @param [TheDude::Command] command The command to register
    def register_command command
      @commands ||= {}
      @commands[command.question] = command
    end

    # Registers a new variable with the dude
    #
    # @param [TheDude::Variable] variable The variable to register
    def register_variable variable
      @variables ||= {}
      @variables[variable.name] = variable
    end

    # Resets the dude
    def reset
      reset_commands
      reset_variables
    end

    # Outputs something use dude-formatting
    def say something
      puts dude_format something
    end

    private

    # @return [String] Applies angry dude formatting for error messages
    def angry_dude_format string
      string
    end

    # Returns the arguments for a question based on the specified command
    #
    # @param [String]           question  The question
    # @param [TheDude::Command] command   The command
    #
    # @return [Array] An array of arguments
    def arguments_for question, command
      question.scan(command.question)[0]
    end

    # @return [String] Applies dude formatting
    def dude_format string
      string
    end

    # Returns the command for answering the specified question
    #
    # @param [String] question The question asked
    #
    # @return [TheDude::Command]
    def find_command_for question
      # if there's an exact match return that first
      return commands[question] if commands[question]

      commands.each do |key, val|
        if key.kind_of? Regexp
          return val if key =~ question
        end
      end

      return false
    end

    # Resets the collection of commands
    def reset_commands
      @commands = {}
    end

    # Resets the collection of commands
    def reset_variables
      @variables = {}
    end

  end

  class UndefinedVariableError < Exception; end
end

require 'the_dude/setup' # Load default commands and variables
